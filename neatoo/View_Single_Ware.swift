import SwiftUI
import SwiftData

struct WareDetailInfo: View {
    let ware: Ware
    
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
                    Text("\(ware.id)")
                }
                HStack {
                    Text("名称")
                    Spacer()
                    Text("\(ware.name)")
                }
                HStack {
                    Text("品牌")
                    Spacer()
                    Text("\(ware.brand)")
                }
                HStack {
                    Text("数量")
                    Spacer()
                    Text("\(ware.number)")
                }
                HStack {
                    Text("价格")
                    Spacer()
                    Text("¥".appending(numberFormatter.string(from: ware.price as NSNumber) ?? "0"))
                }
                HStack {
                    Text("类别")
                    Spacer()
                    Text("\(ware.category)")
                }
                HStack {
                    Text("重要性")
                    Spacer()
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= ware.priority ? "star.fill" : "star")
                            .foregroundColor(.accent)
                    }
                }
                HStack {
                    Text("何时购入")
                    Spacer()
                    Text(dateFormatter.string(from: ware.purchaseDate))
                }
                HStack {
                    Text("何时记录")
                    Spacer()
                    Text(dateFormatter.string(from: ware.recordDate))
                }
                HStack {
                    Text("购于何地")
                    Spacer()
                    Text("\(ware.purchaseFrom)")
                }
                HStack {
                    Text("详细描述")
                    Spacer()
                    Text("\(ware.wareDescription)")
                }
            }
        }
    }
}
