//
//  neatooApp.swift
//  neatoo
//
//  Created by song on 2025/5/30.
//

import SwiftUI

@main
struct neatooApp: App {
    var body: some Scene {
        WindowGroup {
            AppTabView()
                .modelContainer(for: [Ware.self, Clothing.self, Food.self, Task.self, Payment.self, Account.self, Income.self, Counting.self])
        }
    }
}
