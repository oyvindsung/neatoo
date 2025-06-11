import SwiftUI

struct MixView: View {
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
    MixView()
        .modelContainer(for: [Account.self])
}
