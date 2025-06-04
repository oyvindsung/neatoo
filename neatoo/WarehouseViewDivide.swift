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
            
            ForEach(Array(items.prefix(maxCount)).indices, id: \.self) { index in
                let item = items[index]
                NavigationLink(destination: rowDestination(item)) {
                    Text(itemName(item))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 4)
                        .contentShape(Rectangle())
                }
            }
            
            NavigationLink(destination: allItemsView()) {
                Text("所有\(title)")
                    .foregroundColor(.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        .sheet(isPresented: showAddSheet) {
            addItemView()
        }
        .padding(.horizontal)
        .padding(.top)
    }
}


