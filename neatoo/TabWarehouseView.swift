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
            List {
                Section {
                    Button {
                        showAddFoodSheet = true
                    } label: {
                        Text("添加新物品")
                    }
                    ForEach(foods.prefix(6), id: \.id) { food in
                        NavigationLink("\(food.name)") {
                            FoodDetailInfo(food: food)
                        }
                    }
                    NavigationLink("所有食物") {
                        AllFoodView()
                    }
                } header: {
                    Text("食物")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.primary)
                        .textCase(nil)
                        .padding(.top, 8)
                }
                Section {
                    Button {
                        showAddClothingSheet = true
                    } label: {
                        Text("添加新物品")
                    }
                    ForEach(clothing.prefix(6), id: \.id) { clothing in
                        NavigationLink("\(clothing.name)") {
                            ClothingDetailInfo(clothing: clothing)
                        }
                    }
                    NavigationLink("所有衣物") {
                        AllClothingView()
                    }
                } header: {
                    Text("衣物")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.primary)
                        .textCase(nil)
                        .padding(.top, 8)
                }
                Section {
                    Button {
                        showAddWareSheet = true
                    } label: {
                        Text("添加新物品")
                    }
                    ForEach(wares.prefix(6), id: \.id) { ware in
                        NavigationLink("\(ware.name)") {
                            WareDetailInfo(ware: ware)
                        }
                    }
                    NavigationLink("所有杂物") {
                        AllWareView()
                    }
                } header: {
                    Text("杂物")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.primary)
                        .textCase(nil)
                        .padding(.top, 8)
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
        .modelContainer(for: [Ware.self, Clothing.self, Food.self], inMemory: true)
}
