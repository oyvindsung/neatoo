//
//  ContentView.swift
//  neatoo
//
//  Created by song on 2025/5/30.
//

import SwiftUI
import SwiftData

enum ImportWareType: String, CaseIterable, Identifiable {
    case ware = "Ware"
    case food = "Food"
    case clothing = "Clothing"

    var id: String { self.rawValue }
}


struct WarehouseView: View {
    @Query private var wares: [Ware]
    @Query private var clothing: [Clothing]
    @Query private var foods: [Food]
    
    @Environment(\.modelContext) private var context
    
    @State private var showAddWareSheet = false
    @State private var showAddClothingSheet = false
    @State private var showAddFoodSheet = false
    @State private var showImportTypePicker = false
    @State private var selectedImportType: ImportWareType? = nil
    @State private var isImporting = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    CardView(
                        title: "食物",
                        items: foods.sorted { $0.recordDate > $1.recordDate },
                        showAddSheet: $showAddFoodSheet,
                        itemName: { $0.name },
                        rowDestination: { FoodDetailInfo(food: $0) },
                        allItemsView: { AllItemListView(
                            title: "所有食物",
                            items: foods,
                            itemName: { $0.name },
                            toDetail: { food in FoodDetailInfo(food: food) },
                            delete: { indexSet in
                                for index in indexSet {
                                    context.delete(foods[index])
                                    do {
                                        try context.save()
                                    } catch {
                                        print("Failed to save context: \(error)")
                                    }
                                }
                            },
                            filename: "food_data",
                            itemCountDescription: { types, total in
                                "共 \(types) 类，\(total) 个食物"
                            }
                        )},
                        addItemView: {
                            AddNewFoodView { newFood in
                                context.insert(newFood)
                                do {
                                    try context.save()
                                } catch {
                                    print("Failed to save context: \(error)")
                                }
                            }
                        }
                    )
                }
                VStack(spacing: 16) {
                    CardView(
                        title: "衣物",
                        items: clothing.sorted { $0.recordDate > $1.recordDate },
                        showAddSheet: $showAddClothingSheet,
                        itemName: { $0.name },
                        rowDestination: { ClothingDetailInfo(clothing: $0) },
                        allItemsView: { AllItemListView(
                            title: "所有衣物",
                            items: clothing,
                            itemName: { $0.name },
                            toDetail: { clothing in ClothingDetailInfo(clothing: clothing) },
                            delete: { indexSet in
                                for index in indexSet {
                                    context.delete(clothing[index])
                                    do {
                                        try context.save()
                                    } catch {
                                        print("Failed to save context: \(error)")
                                    }
                                }
                            },
                            filename: "clothing_data",
                            itemCountDescription: { types, total in
                                "共 \(types) 类，\(total) 个衣物"
                            }
                        )},
                        addItemView: {
                            AddNewClothingView { newClothing in
                                context.insert(newClothing)
                                do {
                                    try context.save()
                                } catch {
                                    print("Failed to save context: \(error)")
                                }
                            }
                        }
                    )
                }
                VStack(spacing: 16) {
                    CardView(
                        title: "杂物",
                        items: wares.sorted { $0.recordDate > $1.recordDate },
                        showAddSheet: $showAddWareSheet,
                        itemName: { $0.name },
                        rowDestination: { WareDetailInfo(ware: $0) },
                        allItemsView: { AllItemListView(
                            title: "所有杂物",
                            items: wares,
                            itemName: { $0.name },
                            toDetail: { ware in WareDetailInfo(ware: ware) },
                            delete: { indexSet in
                                for index in indexSet {
                                    context.delete(wares[index])
                                    do {
                                        try context.save()
                                    } catch {
                                        print("Failed to save context: \(error)")
                                    }
                                }
                            },
                            filename: "ware_data",
                            itemCountDescription: { types, total in
                                "共 \(types) 类，\(total) 个杂物"
                            }
                        )},
                        addItemView: {
                            AddNewWareView { newWare in
                                context.insert(newWare)
                                do {
                                    try context.save()
                                } catch {
                                    print("Failed to save context: \(error)")
                                }
                            }
                        }
                    )
                }
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
                ForEach(ImportWareType.allCases) { type in
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

                    switch selectedImportType {
                    case .ware:
                        let decodedItems = try decoder.decode([Ware].self, from: data)
                        for item in decodedItems {
                            context.insert(item)
                            do {
                                try context.save()
                            } catch {
                                print("Failed to save context: \(error)")
                            }
                        }
                    case .food:
                        let decodedItems = try decoder.decode([Food].self, from: data)
                        for item in decodedItems {
                            context.insert(item)
                            do {
                                try context.save()
                            } catch {
                                print("Failed to save context: \(error)")
                            }
                        }
                    case .clothing:
                        let decodedItems = try decoder.decode([Clothing].self, from: data)
                        for item in decodedItems {
                            context.insert(item)
                            do {
                                try context.save()
                            } catch {
                                print("Failed to save context: \(error)")
                            }
                        }
                    case .none:
                        print("No import type selected")
                    }
                } catch {
                    print("Import failed: \(error)")
                }
            }
            .navigationTitle("仓库")
        }
    }
}

//#Preview {
//    WarehouseView()
//        .modelContainer(for: [Ware.self, Clothing.self, Food.self])
//}
