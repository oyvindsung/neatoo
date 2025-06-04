import SwiftUI
import SwiftData

struct ClothingDetailInfo: View {
    let clothing: Clothing
    
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
                    Text("\(clothing.id)")
                }
                HStack {
                    Text("名称")
                    Spacer()
                    Text("\(clothing.name)")
                }
                HStack {
                    Text("品牌")
                    Spacer()
                    Text("\(clothing.brand)")
                }
                HStack {
                    Text("颜色")
                    Spacer()
                    Text("\(clothing.color)")
                }
                HStack {
                    Text("数量")
                    Spacer()
                    Text("\(clothing.number)")
                }
                HStack {
                    Text("价格")
                    Spacer()
                    Text("¥".appending(numberFormatter.string(from: clothing.price as NSNumber) ?? "0"))
                }
                HStack {
                    Text("类别")
                    Spacer()
                    Text("\(clothing.category)")
                }
                HStack {
                    Text("季节")
                    Spacer()
                    HStack {
                        if clothing.seasons.contains("Spring") {
                            Text("春")
                        }
                        if clothing.seasons.contains("Summer") {
                            Text("夏")
                        }
                        if clothing.seasons.contains("Autumn") {
                            Text("秋")
                        }
                        if clothing.seasons.contains("Winter") {
                            Text("冬")
                        }
                    }
                }
                HStack {
                    Text("何时购入")
                    Spacer()
                    Text(dateFormatter.string(from: clothing.purchaseDate))
                }
                HStack {
                    Text("何时记录")
                    Spacer()
                    Text(dateFormatter.string(from: clothing.recordDate))
                }
                HStack {
                    Text("购于何地")
                    Spacer()
                    Text("\(clothing.purchaseFrom)")
                }
                HStack {
                    Text("详细描述")
                    Spacer()
                    Text("\(clothing.clothingDescription)")
                }
            }
        }
    }
}
