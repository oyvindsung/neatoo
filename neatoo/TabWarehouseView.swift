//
//  ContentView.swift
//  neatoo
//
//  Created by song on 2025/5/30.
//

import SwiftUI
import SwiftData

struct WarehouseView: View {
    @Query private var wares: [Ware]
    @Query private var clothing: [Clothing]
    @Query private var foods: [Food]
    
    @Environment(\.modelContext) private var context
    
    @State private var showAddWareSheet = false
    @State private var showAddClothingSheet = false
    @State private var showAddFoodSheet = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    WarehouseViewDivide(
                        title: "食物",
                        items: foods.sorted { $0.recordDate > $1.recordDate },
                        showAddSheet: $showAddFoodSheet,
                        itemName: { $0.name },
                        rowDestination: { FoodDetailInfo(food: $0) },
                        allItemsView: { AllItemListView(
                            title: "所有食物",
                            items: foods,
                            toDetail: { food in FoodDetailInfo(food: food) },
                            delete: { indexSet in
                                for index in indexSet {
                                    context.delete(foods[index])
                                }
                            },
                            filename: "food_data",
                            itemCountDescription: { types, total in
                                "共 \(types) 类，\(total) 个食物"
                            }
                        )},
                        addItemView: {
                            AddNewFoodView { newFood in context.insert(newFood) }
                        }
                    )
                }
                VStack(spacing: 16) {
                    WarehouseViewDivide(
                        title: "衣物",
                        items: clothing.sorted { $0.recordDate > $1.recordDate },
                        showAddSheet: $showAddClothingSheet,
                        itemName: { $0.name },
                        rowDestination: { ClothingDetailInfo(clothing: $0) },
                        allItemsView: { AllItemListView(
                            title: "所有衣物",
                            items: clothing,
                            toDetail: { clothing in ClothingDetailInfo(clothing: clothing) },
                            delete: { indexSet in
                                for index in indexSet {
                                    context.delete(clothing[index])
                                }
                            },
                            filename: "clothing_data",
                            itemCountDescription: { types, total in
                                "共 \(types) 类，\(total) 个衣物"
                            }
                        )},
                        addItemView: {
                            AddNewClothingView { newClothing in context.insert(newClothing) }
                        }
                    )
                }
                VStack(spacing: 16) {
                    WarehouseViewDivide(
                        title: "杂物",
                        items: wares.sorted { $0.recordDate > $1.recordDate },
                        showAddSheet: $showAddWareSheet,
                        itemName: { $0.name },
                        rowDestination: { WareDetailInfo(ware: $0) },
                        allItemsView: { AllItemListView(
                            title: "所有杂物",
                            items: wares,
                            toDetail: { ware in WareDetailInfo(ware: ware) },
                            delete: { indexSet in
                                for index in indexSet {
                                    context.delete(wares[index])
                                }
                            },
                            filename: "ware_data",
                            itemCountDescription: { types, total in
                                "共 \(types) 类，\(total) 个杂物"
                            }
                        )},
                        addItemView: {
                            AddNewWareView { newWare in context.insert(newWare) }
                        }
                    )
                }
            }
            .sheet(isPresented: $showAddWareSheet) {
                AddNewWareView { newWare in
                    context.insert(newWare)
                }
            }
            .sheet(isPresented: $showAddFoodSheet) {
                AddNewFoodView { newFood in
                    context.insert(newFood)
                }
            }
            .sheet(isPresented: $showAddClothingSheet) {
                AddNewClothingView { newClothing in
                    context.insert(newClothing)
                }
            }
            .navigationTitle("仓库")
        }
    }
}

#Preview {
    WarehouseView()
        .modelContainer(for: [Ware.self, Clothing.self, Food.self], inMemory: false)
}
