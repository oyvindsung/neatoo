import SwiftUI
import SwiftData

struct FoodDetailInfo: View {
    let food: Food
    
    //    var bestBefore: Date
    //    var brand: String
    //    var category: String
    //    var foodDescription: String
    //    var name: String
    //    var number: Double
    //    var price: Double
    //    var purchaseDate: Date
    //    var purchaseFrom: String
    //    var recordDate: Date
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
                    Text("\(food.bestBefore)")
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
                    Text("\(food.price)")
                }
                HStack {
                    Text("类别")
                    Spacer()
                    Text("\(food.category)")
                }
                HStack {
                    Text("何时购入")
                    Spacer()
                    Text("\(food.purchaseDate)")
                }
                HStack {
                    Text("何时记录")
                    Spacer()
                    Text("\(food.recordDate)")
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
