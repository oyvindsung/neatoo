import SwiftUI
import SwiftData

struct IncomeDetailView: View {
    let income: Income
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        return dateFormatter
    }
    
    private var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }

    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Text("ID")
                    Spacer()
                    Text("\(income.id)")
                }
                HStack {
                    Text("名称")
                    Spacer()
                    Text("\(income.name)")
                }
                HStack {
                    Text("收入账户")
                    Spacer()
                    Text("\(income.account)")
                }
                HStack {
                    Text("收入金额")
                    Spacer()
                    Text("¥ \(numberFormatter.string(from: income.amount as NSNumber) ?? "0")")
                }
                HStack {
                    Text("收入类别")
                    Spacer()
                    Text("\(income.category.rawValue)")
                }
                HStack {
                    Text("收入日期")
                    Spacer()
                    Text(dateFormatter.string(from: income.date))
                }
            }
        }
    }
}
