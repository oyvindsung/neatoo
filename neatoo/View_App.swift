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
                    .modelContainer(for: Task.self)
            }
            .tabItem {
                Image(systemName: "clock.fill")
            }
            NavigationStack {
                WarehouseView()
                    .modelContainer(for: [Ware.self, Clothing.self, Food.self])
            }
            .tabItem {
                Image(systemName: "door.garage.closed")
            }
        }

    }
}

#Preview {
    AppTabView()
        .modelContainer(for: [Ware.self, Clothing.self, Food.self, Task.self])
}
