//
//  AllWarehouseInfoView.swift
//  neatoo
//
//  Created by song on 2025/6/2.
//

import SwiftUI
import SwiftData

struct AllItemListView<Item: Identifiable & Codable, DetailView: View>: View {
    let title: String
    let items: [Item]
    let toDetail: (Item) -> DetailView
    let delete: (IndexSet) -> Void
    let filename: String
    let itemCountDescription: (Int, Int) -> String
    
    @State private var editMode: EditMode = .inactive
    @State private var exportData: Data?
    @State private var isExporting = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items, id: \.id) { item in
                    NavigationLink("\(itemName(from: item))") {
                        toDetail(item)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle(title)
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
                        exportItems()
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                    }
                }
            }
            .safeAreaInset(edge: .bottom, content: {
                Text(itemCountDescription(items.count, items.reduce(0) { $0 + (itemCount(from: $1)) }))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.ultraThinMaterial)
            })
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
    
    // MARK: - Helpers
    
    private func exportItems() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            encoder.dateEncodingStrategy = .iso8601
            exportData = try encoder.encode(items)
            isExporting = true
        } catch {
            print("Export failed: \(error)")
        }
    }
    
    // These can be specialized via override/extension if needed
    private func itemName(from item: Item) -> String {
        (item as? Ware)?.name ?? "Item"
    }
    
    private func itemCount(from item: Item) -> Int {
        (item as? Ware).map { Int($0.number) } ?? 1
    }
}
