//
//  AddNewFoodView.swift
//  neatoo
//
//  Created by song on 2025/6/1.
//
import SwiftUI
import SwiftData

struct AddNewFoodView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    // food var
    @State private var bestBefore: Date = .now
    @State private var brand: String = ""
    @State private var category: String = ""
    @State private var foodDescription: String = ""
    @State private var name: String = ""
    @State private var number: Double = 0
    @State private var price: Double = 0
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
    
    @State private var forgetBrand = false
    @State private var forgetPurchaseDate = false
    @State private var forgetPrice = false
    @State private var forgetPurchaseFrom = false
    
    var onAdd: (Food) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("基本信息")) {
                    // name
                    TextField("名称", text: $name)
                    // brand
                    TextField("品牌", text: $brand)
                    // number
                    HStack {
                        Text("数量")
                        Spacer()
                        TextField("", value: $number, format: .number)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    // price
                    HStack {
                        Text("价格")
                        Spacer()
                        TextField("", value: $price, format: .number)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    // best before
                    HStack {
                        Text("保质期至")
                        Spacer()
                        DatePicker(selection: $bestBefore) {
                            Text("")
                        }
                    }
                    // category
                    Picker(selection: $category) {
                        Text("面制品").tag("面制品")
                        Text("肉制品").tag("肉制品")
                        Text("蔬菜").tag("蔬菜")
                        Text("熟食").tag("熟食")
                        Text("预制品").tag("预制品")
                        Text("调味/酱").tag("调味/酱")
                        Text("乳制品").tag("乳制品")
                        Text("不可分类").tag("不可分类")
                    } label: {
                        Text("类别")
                    }
                }
                // food details
                Section(header: Text("详细信息")) {
                    // purchase date
                    HStack {
                        Text("何时购入")
                        Spacer()
                        DatePicker(selection: $purchaseDate) {
                            Text("")
                        }
                    }
                    //  record date
                    HStack {
                        Text("何时记录")
                        Spacer()
                        DatePicker(selection: $recordDate) {
                            Text("")
                        }
                    }
                    // purchase from
                    TextField("购于何地", text: $purchaseFrom)
                    // description
                    TextField("详细描述", text: $foodDescription)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") {
                        let food = Food(bestBefore: bestBefore, brand: brand, category: category, foodDescription: foodDescription, name: name, number: number, price: price, purchaseDate: purchaseDate, purchaseFrom: purchaseFrom, recordDate: recordDate)
                        onAdd(food)
                        
                        dismiss()
                    }
                    .disabled(name.isEmpty || number <= 0 || price < 0)
                }
            }
        }
    }
}
