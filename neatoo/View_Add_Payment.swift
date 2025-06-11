import SwiftUI
import SwiftData

struct AddNewPaymentView: View {
    @Query private var accounts: [Account]
    @Environment(\.dismiss) private var dismiss
    
    @State private var accountID: UUID?
    @State private var amount: Double = 0
    @State private var category: PaymentCategory = .education
    @State private var date: Date = .now
    @State private var how: String = ""
    @State private var name: String = ""
    @State private var priority: Int = 0
    
    var account: Account? {
        accounts.first(where: { $0.id == accountID })
    }
    
    var onAdd: (Payment) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                // name
                TextField("名称", text: $name)
                // how
                Picker(selection: $how) {
                    Text("微信").tag("微信")
                    Text("支付宝").tag("支付宝")
                    Text("云闪付").tag("云闪付")
                    Text("校园卡").tag("校园卡")
                    Text("美团").tag("美团")
                    Text("滴滴").tag("滴滴")
                    Text("现金").tag("现金")
                } label: {
                    Text("支付方式")
                }
                // account
                Picker(selection: $accountID) {
                    ForEach(accounts) { acc in
                        Text(acc.name).tag(acc.id)
                    }
                } label: {
                    Text("支付账户")
                }
                // amount
                HStack {
                    Text("支付金额")
                    Spacer()
                    TextField("", value: $amount, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                // category
                Picker("所属类别", selection: $category) {
                    ForEach(PaymentCategory.allCases) { payment in
                        Text(payment.rawValue).tag(payment)
                    }
                }
                // priority
                HStack {
                    Text("重要性")
                    Spacer()
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= priority ? "star.fill" : "star")
                            .foregroundColor(.accent)
                            .onTapGesture {
                                priority = index
                            }
                    }
                }
                // date
                HStack {
                    Text("支付日期")
                    Spacer()
                    DatePicker(selection: $date) {
                        Text("")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") {
                        let payment = Payment(account: account ?? Account(serial: "XXXX", bank: "XX", balance: 0, name: "XXXX", type: "XXX"), amount: amount, category: category, date: date, how: how, name: name, priority: priority)
                        onAdd(payment)
                        
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddNewPaymentView { payment in
        print("")
    }
}
