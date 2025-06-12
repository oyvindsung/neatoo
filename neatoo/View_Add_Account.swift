import SwiftUI
import SwiftData

struct AddNewAccount: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var serial: String = ""
    @State private var bank: String = ""
    @State private var balance: Double = -1
    @State private var name: String = ""
    @State private var type: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                // serial
                TextField("账户后四位", text: $serial)
                // name
                TextField("账户名称", text: $name)
                // type
                Picker(selection: $type) {
                    Text("储蓄卡").tag("微信")
                    Text("信用卡").tag("支付宝")
                    Text("数字人民币").tag("数字人民币")
                    Text("校园卡").tag("校园卡")
                    Text("微信余额").tag("微信余额")
                    Text("支付宝余额").tag("支付宝余额")
                } label: {
                    Text("账户类型")
                }
                // bank
                TextField("开户银行/所属机构", text: $bank)
                // amount
                HStack {
                    Text("账户余额")
                    Spacer()
                    TextField("", value: $balance, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") {
                        let account = Account(serial: serial, bank: bank, balance: balance, name: name, type: type)
                        context.insert(account)
                        do {
                            try context.save()
                        } catch {
                            print("Failed to save context: \(error)")
                        }
                        dismiss()
                    }
                    .disabled(name.isEmpty || serial.isEmpty || type.isEmpty || balance <= 0)
                }
            }
        }
    }
}
