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
            }
            .tabItem {
                Image(systemName: "door.garage.closed")
            }
            NavigationStack {
                MixView()
            }
            .tabItem {
                Image(systemName: "teddybear.fill")
            }
        }
        .modelContainer(for: [Ware.self, Clothing.self, Food.self, Task.self, Payment.self, Account.self, Income.self])
    }
}

#Preview {
    AppTabView()
        .modelContainer(for: [Ware.self, Clothing.self, Food.self, Payment.self, Task.self, Account.self, Income.self])
}
