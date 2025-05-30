import SwiftUI
import SwiftData

struct ClothingDetailInfo: View {
    let clothing: Clothing
    
    //    var brand: String
    //    var category: String
    //    var clothingDescription: String
    //    var color: String
    //    var name: String
    //    var number: Double
    //    var price: Double
    //    var priority: Int
    //    var purchaseDate: Date
    //    var purchaseFrom: String
    //    var recordDate: Date
    //    var season: [String]
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
                    Text("\(clothing.price)")
                }
                HStack {
                    Text("类别")
                    Spacer()
                    Text("\(clothing.category)")
                }
                HStack {
                    Text("季节")
                    Spacer()
                    Text("\(clothing.season)")
                }
                HStack {
                    Text("何时购入")
                    Spacer()
                    Text("\(clothing.purchaseDate)")
                }
                HStack {
                    Text("何时记录")
                    Spacer()
                    Text("\(clothing.recordDate)")
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
