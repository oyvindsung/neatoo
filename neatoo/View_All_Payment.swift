import SwiftUI
import SwiftData

struct AllPaymentListView<DetailView: View>: View {
    //MARK: - parameters
    let payments: [Payment]
    let toDetail: (Payment) -> DetailView
    let delete: (IndexSet) -> Void
    let filename: String
    
    @State private var editMode: EditMode = .inactive
    @State private var exportData: Data?
    @State private var isExporting = false
    @State private var selectedCategory: String = "全部"

    var categories: [String] {
        let all = payments.map(\.category.rawValue)
        return ["全部"] + Array(Set(all)).sorted()
    }
    
    var filteredPayments: [Payment] {
        if selectedCategory == "全部" {
            return payments
        } else {
            return payments.filter { $0.category.rawValue == selectedCategory }
        }
    }
    
    var totalPaymentAmount: Double {
        var amount: Double = 0.0
        
        for payment in filteredPayments {
            amount += payment.amount
        }
        
        return amount
    }
    
    // MARK: - functions
    private func exportTasks() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            encoder.dateEncodingStrategy = .iso8601
            exportData = try encoder.encode(payments)
            isExporting = true
        } catch {
            print("Export failed: \(error)")
        }
    }
    
    // MARK: - view
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Picker("筛选", selection: $selectedCategory) {
                            ForEach(categories, id: \.self) { cat in
                                Text(cat).tag(cat)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        Spacer()
                    }
                    .padding(.horizontal)
                    .listRowInsets(EdgeInsets())
                }
                Section {
                    ForEach(filteredPayments) { payment in
                        NavigationLink("\(payment.name)") {
                            toDetail(payment)
                        }
                    }
                    .onDelete(perform: delete)
                    .padding(.horizontal)
                }
                .listRowInsets(EdgeInsets())
                Section {
                    Text("共支出 ¥ \(totalPaymentAmount, specifier: "%.2f")")
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal)
                }
            }
            .listSectionSpacing(12)
            .navigationTitle("所有支出")
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.editMode, $editMode)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.easeInOut) {
                            editMode = editMode == .active ? .inactive : .active
                        }
                    } label: {
                        Image(systemName: editMode == .active ? "checkmark" : "pencil")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        exportTasks()
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                    }
                }
            }
            .fileExporter(
                isPresented: $isExporting,
                document: JSONExportDocument(data: exportData ?? Data()),
                contentType: .json,
                defaultFilename: filename
            ) { result in
                if case let .failure(error) = result {
                    print("Export failed: \(error.localizedDescription)")
                }
            }
        }
    }
}

//
//#Preview {
//    AllPaymentListView()
//}
