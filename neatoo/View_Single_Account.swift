//
//  View_Single_Account.swift
//  neatoo
//
//  Created by song on 2025/6/11.
//

import SwiftUI

struct AccountDetailInfo: View {
    let account: Account
    
    private var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }
    
    var body: some View {
        Form {
            HStack {
                Text("账户序号")
                Spacer()
                Text(account.serial)
            }
            HStack {
                Text("账户名称")
                Spacer()
                Text(account.name)
            }
            HStack {
                Text("开户银行/所属机构")
                Spacer()
                Text(account.bank)
            }
            HStack {
                Text("账户类型")
                Spacer()
                Text(account.type)
            }
            HStack {
                Text("账户余额")
                Spacer()
                Text("¥ \(numberFormatter.string(from: account.balance as NSNumber) ?? "0")")
            }
        }
    }
}

#Preview {
    AccountDetailInfo(account: Account(serial: "1001", bank: "A", balance: 1000000, name: "B", type: "C"))
}
