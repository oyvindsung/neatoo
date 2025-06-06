//
//  WarehouseViewDivide.swift
//  neatoo
//
//  Created by song on 2025/6/2.
//

import SwiftUI

struct CardView<Item, RowView: View, AddView: View, AllItemsView: View>: View {
    
    var title: String
    var items: [Item]
    var maxCount: Int = 6
    var showAddSheet: Binding<Bool>
    var itemName: (Item) -> String
    var rowDestination: (Item) -> RowView
    var allItemsView: () -> AllItemsView
    var addItemView: () -> AddView
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.title2)
                    .bold()
                Spacer()
                Button(action: {
                    showAddSheet.wrappedValue = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(.accent)
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            ForEach(Array(items.prefix(maxCount)).indices, id: \.self) { index in
                let item = items[index]
                NavigationLink(destination: rowDestination(item)) {
                    Text(itemName(item))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 4)
                        .padding(.horizontal)
                        .contentShape(Rectangle())
                }
            }
            
            NavigationLink(destination: allItemsView()) {
                Text("显示全部")
                    .foregroundColor(.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
        .padding(.horizontal)
        .padding(.bottom, 4)
        .sheet(isPresented: showAddSheet) {
            addItemView()
        }
    }
}

#Preview {
    CardView<Ware, Text, Text, Text>(
        title: "电器",
        items: [
            Ware(id: UUID(), brand: "", category: "厨具", name: "Spoon", number: 2, price: 3, priority: 3, purchaseDate: .now, purchaseFrom: "", recordDate: .now, wareDescription: ""),
            Ware(id: UUID(), brand: "", category: "厨具", name: "Spoon", number: 2, price: 3, priority: 3, purchaseDate: .now, purchaseFrom: "", recordDate: .now, wareDescription: ""),
            Ware(id: UUID(), brand: "", category: "厨具", name: "Spoon", number: 2, price: 3, priority: 3, purchaseDate: .now, purchaseFrom: "", recordDate: .now, wareDescription: "")
        ],
        showAddSheet: .constant(false),
        itemName: { $0.name },
        rowDestination: { ware in
            Text("查看：\(ware.name)")
        },
        allItemsView: {
            Text("所有电器")
        },
        addItemView: {
            Text("添加新电器")
        }
    )
}

