import SwiftUI
import SwiftData

struct AddNewIncome: View {
    @Query private var accounts: [Account]
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var accountID: UUID?
    @State private var amount: Double = 0
    @State private var category: IncomeCategory = .job
    @State private var date: Date = .now
    @State private var name: String = ""
    
    var account: String {
        let acc = accounts.first(where: { $0.id == accountID })
        return (acc?.bank ?? "") + (acc?.serial ?? "")
    }
    
    var onAdd: (Income) -> Void
    
    private func AddIncomeToAccount() {
        accounts.first(where: { $0.id == accountID })?.balance += amount
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // name
                TextField("名称", text: $name)
                // account
                Picker(selection: $accountID) {
                    ForEach(accounts) { acc in
                        Text("\(acc.bank)\(acc.serial)").tag(acc.id)
                    }
                } label: {
                    Text("收入账户")
                }
                // amount
                HStack {
                    Text("收入金额")
                    Spacer()
                    TextField("", value: $amount, format: .number)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                // category
                Picker("收入类别", selection: $category) {
                    ForEach(IncomeCategory.allCases) { income in
                        Text(income.rawValue).tag(income)
                    }
                }
                // date
                HStack {
                    Text("收入日期")
                    Spacer()
                    DatePicker(selection: $date) {
                        Text("")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") {
                        let income = Income(account: account, amount: amount, category: category, date: date, name: name)
                        onAdd(income)
                        AddIncomeToAccount()
                        do {
                            try context.save()
                        } catch {
                            print("Failed to save context: \(error)")
                        }
                        dismiss()
                    }
                    .disabled(name.isEmpty || amount <= 0)
                }
            }
        }
    }
}

#Preview {
    AddNewIncome { income in
        print("")
    }
}
