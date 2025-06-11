import SwiftUI
import SwiftData

struct AppTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                FinanceView()
//                    .modelContainer(for: [Payment.self, Account.self])
            }
            .tabItem {
                Image(systemName: "wallet.bifold.fill")
            }
            NavigationStack {
                TimeView()
//                    .modelContainer(for: Task.self)
            }
            .tabItem {
                Image(systemName: "clock.fill")
            }
            NavigationStack {
                WarehouseView()
//                    .modelContainer(for: [Ware.self, Clothing.self, Food.self])
            }
            .tabItem {
                Image(systemName: "door.garage.closed")
            }
            NavigationStack {
                MixView()
//                    .modelContainer(for: [Account.self])
            }
            .tabItem {
                Image(systemName: "teddybear.fill")
            }
        }
        .modelContainer(for: [Ware.self, Clothing.self, Food.self, Task.self, Payment.self, Account.self])
    }
}

#Preview {
    AppTabView()
        .modelContainer(for: [Ware.self, Clothing.self, Food.self, Payment.self, Task.self, Account.self])
}
