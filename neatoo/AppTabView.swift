//
//  AppTabView.swift
//  neatoo
//
//  Created by song on 2025/6/1.
//

import SwiftUI
import SwiftData

struct AppTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                FinanceView()
            }
            .tabItem {
                Image(systemName: "wallet.bifold.fill")
            }
            NavigationStack {
                TimeView()
            }
            .tabItem {
                Image(systemName: "clock.fill")
            }
            NavigationStack {
                WarehouseView()
                    .modelContainer(for: [Ware.self, Clothing.self, Food.self])
            }
            .tabItem {
                Image(systemName: "archivebox.fill")
            }
        }

    }
}

#Preview {
    AppTabView()
        .modelContainer(for: [Ware.self, Clothing.self, Food.self], inMemory: true)
}
