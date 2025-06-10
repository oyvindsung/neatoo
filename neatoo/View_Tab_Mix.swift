//
//  View_Tab_Mix.swift
//  neatoo
//
//  Created by song on 2025/6/10.
//

import SwiftUI

struct MixView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MixView()
}

import SwiftUI
import SwiftData

struct FinanceView: View {
    @Query private var payments: [Payment]
    
    @Environment(\.modelContext) private var context
    
    @State private var showAddPaymentSheet = false
    @State private var isImporting = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TimeChartView()
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
                    .modelContainer(for: Payment.self)
                    },
                    addItemView: {
                        AddNewPaymentView { newPayment in context.insert(newPayment) }
                    }
                )
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isImporting = true
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
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

                    let decodedItems = try decoder.decode([Payment].self, from: data)
                    for item in decodedItems {
                        withAnimation {
                            context.insert(item)
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
