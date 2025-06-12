import SwiftUI
import SwiftData

struct AppTabView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.modelContext) private var context

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
                CountingView()
            }
            .tabItem {
                Image(systemName: "calendar.badge.exclamationmark")
            }
            NavigationStack {
                SettingView()
            }
            .tabItem {
                Image(systemName: "teddybear.fill")
            }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            if newPhase == .background {
                do {
                    try context.save()
                } catch {
                    print("Failed to save context: \(error)")
                }
            }
        }
    }
}

#Preview {
    AppTabView()
        .modelContainer(for: [Ware.self, Clothing.self, Food.self, Payment.self, Task.self, Account.self, Income.self, Counting.self])
}
