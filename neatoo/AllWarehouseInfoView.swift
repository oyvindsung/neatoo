//
//  AllWarehouseInfoView.swift
//  neatoo
//
//  Created by song on 2025/6/2.
//

import SwiftUI
import SwiftData

struct AllItemListView<Item: Identifiable & Codable & Categorizable, DetailView: View>: View {
    //MARK: - parameters
    let title: String
    let items: [Item]
    let itemName: (Item) -> String
    let toDetail: (Item) -> DetailView
    let delete: (IndexSet) -> Void
    let filename: String
    let itemCountDescription: (Int, Int) -> String
    
    @State private var editMode: EditMode = .inactive
    @State private var exportData: Data?
    @State private var isExporting = false
    @State private var selectedCategory: String = "全部"

    var categories: [String] {
        let all = items.map(\.category)
        return ["全部"] + Array(Set(all)).sorted()
    }
    
    var filteredItems: [Item] {
        if selectedCategory == "全部" {
            return items
        } else {
            return items.filter { $0.category == selectedCategory }
        }
    }
    
    // MARK: - functions
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
    
    private func itemName(from item: Item) -> String {
        (item as? Ware)?.name ?? "Item"
    }
    
    private func itemCount(from item: Item) -> Int {
        (item as? Ware).map { Int($0.number) } ?? 1
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
                    ForEach(filteredItems) { item in
                        NavigationLink("\(itemName(item))") {
                            toDetail(item)
                        }
                    }
                    .onDelete(perform: delete)
                    .padding(.horizontal)
                }
                .listRowInsets(EdgeInsets())
                Section {
                    Text("共 " + "\(filteredItems.count)" + " 类，" + "\(filteredItems.reduce(0) { $0 + (itemCount(from: $1)) })" + " 个")
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal)
                }
            }
            .listSectionSpacing(12)
            .navigationTitle(title)
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
                        exportItems()
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
