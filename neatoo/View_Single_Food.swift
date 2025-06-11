import SwiftUI
import SwiftData

struct FoodDetailInfo: View {
    let food: Food
    
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
                    Text("\(food.id)")
                }
                HStack {
                    Text("名称")
                    Spacer()
                    Text("\(food.name)")
                }
                HStack {
                    Text("有效期至")
                    Spacer()
                    Text(dateFormatter.string(from: food.bestBefore))
                }
                HStack {
                    Text("品牌")
                    Spacer()
                    Text("\(food.brand)")
                }
                HStack {
                    Text("数量")
                    Spacer()
                    Text("\(food.number)")
                }
                HStack {
                    Text("价格")
                    Spacer()
                    Text("¥ \(numberFormatter.string(from: food.price as NSNumber) ?? "0")")
                }
                HStack {
                    Text("类别")
                    Spacer()
                    Text("\(food.category)")
                }
                HStack {
                    Text("何时购入")
                    Spacer()
                    Text(dateFormatter.string(from: food.purchaseDate))
                }
                HStack {
                    Text("何时记录")
                    Spacer()
                    Text(dateFormatter.string(from: food.recordDate))
                }
                HStack {
                    Text("购于何地")
                    Spacer()
                    Text("\(food.purchaseFrom)")
                }
                HStack {
                    Text("详细描述")
                    Spacer()
                    Text("\(food.foodDescription)")
                }
            }
        }
    }
}
