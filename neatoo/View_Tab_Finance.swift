import SwiftUI
import SwiftData

enum ImportFinanceType: String, CaseIterable, Identifiable {
    case income = "Income"
    case payment = "Payment"

    var id: String { self.rawValue }
}

struct FinanceView: View {
    @Query private var payments: [Payment]
    @Query private var incomes: [Income]
    
    @Environment(\.modelContext) private var context
    
    @State private var showAddPaymentSheet = false
    @State private var showAddIncomeSheet = false
    @State private var isImporting = false
    @State private var selectedImportType: ImportFinanceType? = nil
    @State private var showImportTypePicker = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                PaymentChartView()
                CardView(
                    title: "支出",
                    items: payments.sorted { $0.date > $1.date },
                    showAddSheet: $showAddPaymentSheet,
                    itemName: { $0.name },
                    rowDestination: { payment in PaymentDetailView(payment: payment) },
                    allItemsView: { AllPaymentListView(
                        payments: payments,
                        toDetail: { payment in PaymentDetailView(payment: payment) },
                        delete: { indexSet in
                            for index in indexSet {
                                context.delete(payments[index])
                            }
                        },
                        filename: "payment_data"
                    )
                    },
                    addItemView: {
                        AddNewPaymentView { newPayment in context.insert(newPayment) }
                    }
                )
                CardView(
                    title: "收入",
                    items: incomes.sorted { $0.date > $1.date },
                    showAddSheet: $showAddIncomeSheet,
                    itemName: { $0.name },
                    rowDestination: { income in IncomeDetailView(income: income) },
                    allItemsView: { AllIncomeListView(
                        incomes: incomes,
                        toDetail: { income in IncomeDetailView(income: income) },
                        delete: { indexSet in
                            for index in indexSet {
                                context.delete(incomes[index])
                            }
                        },
                        filename: "income_data"
                    )
                    },
                    addItemView: {
                        AddNewIncome { newIncome in context.insert(newIncome)
                            do {
                                try context.save()
                            } catch {
                                print("Failed to save context: \(error)")
                            }
                        }
                    }
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showImportTypePicker = true
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            .confirmationDialog("选择导入的数据类型", isPresented: $showImportTypePicker, titleVisibility: .visible) {
                ForEach(ImportFinanceType.allCases) { type in
                    Button(type.rawValue) {
                        selectedImportType = type
                        isImporting = true
                    }
                }
                Button("取消", role: .cancel) { }
            }
            .fileImporter(
                isPresented: $isImporting,
                allowedContentTypes: [.json]
            ) { result in
                do {
                    let fileURL = try result.get()
                    guard fileURL.startAccessingSecurityScopedResource() else {
                        print("没有读取权限")
                        return
                    }
                    defer { fileURL.stopAccessingSecurityScopedResource() }
                    
                    let data = try Data(contentsOf: fileURL)
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601

                    if selectedImportType == .income {
                        let decodedItems = try decoder.decode([Income].self, from: data)
                        for item in decodedItems {
                            withAnimation {
                                context.insert(item)
                                do {
                                    try context.save()
                                } catch {
                                    print("Failed to save context: \(error)")
                                }
                            }
                        }
                    } else {
                        let decodedItems = try decoder.decode([Payment].self, from: data)
                        for item in decodedItems {
                            withAnimation {
                                context.insert(item)
                                do {
                                    try context.save()
                                } catch {
                                    print("Failed to save context: \(error)")
                                }
                            }
                        }
                    }
                    
                } catch {
                    print("Import failed: \(error)")
                }
            }
            .navigationTitle("记账")
        }
    }
}

#Preview {
    FinanceView()
        .modelContainer(for: [Payment.self])
}
