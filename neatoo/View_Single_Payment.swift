import SwiftUI
import SwiftData

struct PaymentDetailView: View {
    let payment: Payment
    
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
                    Text("\(payment.id)")
                }
                HStack {
                    Text("名称")
                    Spacer()
                    Text("\(payment.name)")
                }
                HStack {
                    Text("支付方式")
                    Spacer()
                    Text("\(payment.how)")
                }
                HStack {
                    Text("支付账户")
                    Spacer()
                    Text("\(payment.account.name)")
                }
                HStack {
                    Text("支付金额")
                    Spacer()
                    Text("\(payment.amount)")
                }
                HStack {
                    Text("类别")
                    Spacer()
                    Text("\(payment.category.rawValue)")
                }
                HStack {
                    Text("重要性")
                    Spacer()
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= payment.priority ? "star.fill" : "star")
                            .foregroundColor(.accent)
                    }
                }
                HStack {
                    Text("支付时间")
                    Spacer()
                    Text(dateFormatter.string(from: payment.date))
                }
            }
        }
    }
}
