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
            Tab("资产", systemImage: "wallet.bifold.fill") {
                FinanceView()
            }

            Tab("时间", systemImage: "clock.fill") {
                TimeView()
            }


            Tab("仓库", systemImage: "archivebox.fill") {
                WarehouseView()
                    .modelContainer(for: [Ware.self, Clothing.self, Food.self])
            }
        }

    }
}

#Preview {
    AppTabView()
        .modelContainer(for: [Ware.self, Clothing.self, Food.self], inMemory: true)
}
