import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationStack {
            Form {
                NavigationLink {
                    AllAccountView()
                } label: {
                    Text("银行账户管理")
                }
            }
            .navigationTitle("设置")
        }
    }
}

#Preview {
    SettingView()
        .modelContainer(for: [Account.self])
}
