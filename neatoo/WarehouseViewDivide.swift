//
//  WarehouseViewDivide.swift
//  neatoo
//
//  Created by song on 2025/6/2.
//

import SwiftUI

struct WarehouseViewDivide<Item, RowView: View, AddView: View, AllItemsView: View>: View {
    var title: String
    var items: [Item]
    var maxCount: Int = 6
    var showAddSheet: Binding<Bool>
    var itemName: (Item) -> String
    var rowDestination: (Item) -> RowView
    var allItemsView: () -> AllItemsView
    var addItemView: () -> AddView

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                Spacer()
                Button(action: {
                    showAddSheet.wrappedValue = true
                }) {
                    Image(systemName: "plus")
                }
            }
            .padding(.horizontal)
            List {
                ForEach(Array(items.prefix(maxCount)).indices, id: \.self) { index in
                    let item = items[index]
                    NavigationLink(destination: rowDestination(item)) {
                        Text(itemName(item))
                    }
                }
                NavigationLink("所有\(title)", destination: allItemsView())
            }
            .frame(height: CGFloat(min(items.count, maxCount) + 1) * 44)
            .listStyle(PlainListStyle())
        }
        .sheet(isPresented: showAddSheet) {
            addItemView()
        }
        .padding(.top)
    }
}

