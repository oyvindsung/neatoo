//
//  AddNewClothingView.swift
//  neatoo
//
//  Created by song on 2025/6/1.
//

import SwiftUI
import SwiftData

enum Category: String, CaseIterable, Identifiable {
    case tops = "上装"
    case bottoms = "裤装"
    case footwear = "鞋履"
    case sunProtection = "防晒用品"
    case sportsClothing = "运动用品"
    case smallClothing = "配饰"
    case jewelry = "首饰"

    var id: String { rawValue }
}

enum MinorCategory: String, Identifiable {
    var id: String { rawValue }

    // 上装
    case singlet = "背心"
    case tShirt = "T-shirt"
    case shirt = "高领衬衫"
    case sweater = "毛衣"
    case jacket = "外套"
    case sweaterShirt = "卫衣"
    case downJacket = "羽绒服"
    // 裤装
    case shorts = "短裤"
    case trousers = "长裤"
    // 鞋履
    case sandals = "拖鞋/洞洞鞋"
    case sneakers = "运动鞋"
    case canvasShoes = "帆布鞋"
    // 防晒用品
    case mask = "防晒面罩"
    case sunJacket = "防晒服"
    // 运动用品
    case sportsBag = "运动腰包"
    case sportsBelt = "运动头巾"
    case sportsTops = "运动上衣"
    case sportsShorts = "运动裤装"
    // 配饰
    case socks = "袜子"
    case underwear = "内裤"
    case hat = "帽子"
    case belt = "腰带"
    case scarf = "围巾"
    case shoeBelt = "鞋带"
    // 首饰
    case necklace = "项链"
    case earings = "耳环/耳钉"

    static func minorCategory(for category: Category) -> [MinorCategory] {
        switch category {
        case .tops:
            return [.singlet, .tShirt, .shirt, .sweater, .jacket, .sweaterShirt, .downJacket]
        case .bottoms:
            return [.shorts, .trousers]
        case .footwear:
            return [.sandals, .sneakers, .canvasShoes]
        case .sunProtection:
            return [.mask, .sunJacket]
        case .sportsClothing:
            return [.sportsBag, .sportsBelt, .sportsTops, .sportsShorts]
        case .smallClothing:
            return [.socks, .underwear, .hat, .belt, .scarf, .shoeBelt]
        case .jewelry:
            return [.necklace, .earings]
        }
    }
}

struct AddNewClothingView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    // food var
    @State private var brand: String = ""
    @State private var clothingDescription: String = ""
    @State private var color: String = ""
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
    @State private var selectedSeasons: [String] = []
    
    @State private var selectedCategory = Category.tops
    @State private var selectedMinorCategory = MinorCategory.singlet
    
    @State private var springSelected = false
    @State private var summerSelected = false
    @State private var autumnSelected = false
    @State private var winterSelected = false
    
    var onAdd: (Clothing) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("基本信息")) {
                    // name
                    TextField("名称", text: $name)
                    // brand
                    TextField("品牌", text: $brand)
                    // color
                    TextField("颜色", text: $color)
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
                    // category
                    Picker("父类", selection: $selectedCategory) {
                        ForEach(Category.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .onChange(of: selectedCategory) {
                        if let firstMinor = MinorCategory.minorCategory(for: selectedCategory).first {
                            selectedMinorCategory = firstMinor
                        }
                    }
                    Picker("子类", selection: $selectedMinorCategory) {
                        ForEach(MinorCategory.minorCategory(for: selectedCategory)) { minor in
                            Text(minor.rawValue).tag(minor)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    // season
                    // spring
                    Toggle("春季", isOn: $springSelected)
                        .toggleStyle(SwitchToggleStyle(tint: .accent))
                    // summer
                    Toggle("夏季", isOn: $summerSelected)
                        .toggleStyle(SwitchToggleStyle(tint: .accent))
                    // autumn
                    Toggle("秋季", isOn: $autumnSelected)
                        .toggleStyle(SwitchToggleStyle(tint: .accent))
                    // winter
                    Toggle("冬季", isOn: $winterSelected)
                        .toggleStyle(SwitchToggleStyle(tint: .accent))
                    // priority
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
                }
                // clothing details
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
                    TextField("详细描述", text: $clothingDescription)
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") {
                        if springSelected {
                            selectedSeasons.append("Spring")
                        }
                        if summerSelected {
                            selectedSeasons.append("Summer")
                        }
                        if autumnSelected {
                            selectedSeasons.append("Autumn")
                        }
                        if winterSelected {
                            selectedSeasons.append("Winter")
                        }
                        let clothing = Clothing(brand: brand, category: selectedMinorCategory.rawValue, clothingDescription: clothingDescription, color: color, name: name, number: number, price: price, priority: priority, purchaseDate: purchaseDate, purchaseFrom: purchaseFrom, recordDate: recordDate, season: selectedSeasons)
                        onAdd(clothing)
                        
                        dismiss()
                    }
                    .disabled(name.isEmpty || number <= 0 || price < 0)
                }
            }
        }
    }
}
