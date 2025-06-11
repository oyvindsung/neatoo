import SwiftUI
import SwiftData
import Charts

struct PaymentChartCategory: Identifiable {
    var category: String
    var number: Int
    var id = UUID()
}

struct PaymentChartView: View {
    @Query private var payments: [Payment]
    
    @Environment(\.modelContext) private var context
    
    let categoryColors: [String: Color] = [
        "衣": .red,
        "食": .orange,
        "住": .yellow,
        "行": .green,
        "教育": .blue,
        "日用": .purple,
        "娱乐": .pink
    ]
    
    private var paymentData: [PaymentChartCategory] {
        var categories: [String: Double] = ["衣": 0, "食": 0, "住": 0, "行": 0, "教育": 0, "日用": 0, "娱乐": 0]
        
        for payment in payments {
            categories[payment.category.rawValue, default: 0] += payment.amount
        }
        
        return categories.map { PaymentChartCategory(category: $0.key, number: Int($0.value)) }
    }
    
    var body: some View {
        Chart {
            ForEach(paymentData.sorted(by: { $0.number > $1.number })) { data in
                    BarMark(
                        x: .value("类别", data.category),
                        y: .value("支出总额", data.number)
                    )
                    .foregroundStyle(categoryColors[data.category] ?? .gray)
                }
        }
        .frame(height: 300)
        .padding()
    }
}

#Preview {
    TimeChartView()
        .modelContainer(for: [Payment.self])
}
