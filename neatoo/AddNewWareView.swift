import SwiftUI
import SwiftData

struct AddNewWareView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    // basic var
    @State private var brand: String = ""
    @State private var category: String = ""
    @State private var name: String = ""
    @State private var number: Int = 0
    @State private var price: Double = 0
    @State private var priority: Int = 0
    @State private var purchaseDate: Date = {
        var components = DateComponents()
        components.year = 2002
        components.month = 6
        components.day = 10
        components.hour = 0
        components.minute = 0
        components.second = 0
        return Calendar.current.date(from: components) ?? Date()
    }()
    @State private var purchaseFrom: String = ""
    @State private var recordDate: Date = .now
    @State private var wareDescription: String = ""
    
    var onAdd: (Ware) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("基本信息")) {
                    TextField("名称", text: $name)
                    HStack {
                        Text("数量")
                        Spacer()
                        TextField("", value: $number, format: .number)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Text("价格")
                        Spacer()
                        TextField("", value: $price, format: .number)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Text("重要性")
                        Spacer()
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: index <= priority ? "star.fill" : "star")
                                .foregroundColor(.accent)
                                .onTapGesture {
                                    priority = index
                                }
                        }
                    }
                    Picker(selection: $category) {
                        Text("电器").tag("电器")
                        Text("家具").tag("家具")
                        Text("厨具").tag("厨具")
                        Text("化妆品").tag("化妆品")
                        Text("运动器材").tag("运动器材")
                        Text("清洁用品").tag("清洁用品")
                        Text("实用工具/材料").tag("实用工具")
                        Text("不可分类").tag("不可分类")
                    } label: {
                        Text("类别")
                    }
                }
                Section(header: Text("详细信息")) {
                    TextField("品牌", text: $brand)
                    HStack {
                        Text("何时购入")
                        Spacer()
                        DatePicker(selection: $purchaseDate) {
                            Text("")
                        }
                    }
                    HStack {
                        Text("何时记录")
                        Spacer()
                        DatePicker(selection: $recordDate) {
                            Text("")
                        }
                    }
                    TextField("购于何地", text: $purchaseFrom)
                    TextField("详细描述", text: $wareDescription)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") {
                        let ware = Ware(brand: brand, category: category, name: name, number: number, price: price, priority: priority, purchaseDate: purchaseDate, purchaseFrom: purchaseFrom, recordDate: recordDate, wareDescription: wareDescription)
                        onAdd(ware)
                        
                        dismiss()
                    }
                    .disabled(name.isEmpty || number <= 0 || price < 0 || priority <= 0)
                }
            }
        }
    }
}
