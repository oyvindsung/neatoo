import SwiftUI
import SwiftData

struct WareDetailInfo: View {
    let ware: Ware
    
    //    var brand: String
    //    var category: String
    //    var name: String
    //    var number: Double
    //    var price: Double
    //    var priority: Int
    //    var purchaseDate: Date
    //    var purchaseFrom: String
    //    var recordDate: Date
    //    var wareDescription: String
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
                    Text("\(ware.price)")
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
                    Text("\(ware.purchaseDate)")
                }
                HStack {
                    Text("何时记录")
                    Spacer()
                    Text("\(ware.recordDate)")
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
