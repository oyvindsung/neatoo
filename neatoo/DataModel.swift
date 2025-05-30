//
//  DataModel.swift
//  neatoo
//
//  Created by song on 2025/5/30.
//

import Foundation
import SwiftData

@Model
class Ware: Identifiable {
    var id = UUID()
    
    var brand: String
    var category: String
    var name: String
    var number: Double
    var price: Double
    var priority: Int
    var purchaseDate: Date
    var purchaseFrom: String
    var recordDate: Date
    var wareDescription: String

    init(id: UUID = UUID(), brand: String, category: String, name: String, number: Double, price: Double, priority: Int, purchaseDate: Date, purchaseFrom: String, recordDate: Date, wareDescription: String) {
        self.id = id
        self.brand = brand
        self.category = category
        self.name = name
        self.number = number
        self.price = price
        self.priority = priority
        self.purchaseDate = purchaseDate
        self.purchaseFrom = purchaseFrom
        self.recordDate = recordDate
        self.wareDescription = wareDescription
    }
}

extension Ware: Encodable {
    enum CodingKeys: String, CodingKey {
        case id, brand, category, name, number, price, priority, purchaseDate, purchaseFrom, recordDate, wareDescription
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(brand, forKey: .brand)
        try container.encode(category, forKey: .category)
        try container.encode(name, forKey: .name)
        try container.encode(number, forKey: .number)
        try container.encode(price, forKey: .price)
        try container.encode(priority, forKey: .priority)
        try container.encode(purchaseDate, forKey: .purchaseDate)
        try container.encode(purchaseFrom, forKey: .purchaseFrom)
        try container.encode(recordDate, forKey: .recordDate)
        try container.encode(wareDescription, forKey: .wareDescription)
    }
}

@Model
class Food: Identifiable {
    var id = UUID()
    
    var bestBefore: Date
    var brand: String
    var category: String
    var foodDescription: String
    var name: String
    var number: Double
    var price: Double
    var purchaseDate: Date
    var purchaseFrom: String
    var recordDate: Date
    
    init(id: UUID = UUID(), bestBefore: Date, brand: String, category: String, foodDescription: String, name: String, number: Double, price: Double, purchaseDate: Date, purchaseFrom: String, recordDate: Date) {
        self.id = id
        self.bestBefore = bestBefore
        self.brand = brand
        self.category = category
        self.foodDescription = foodDescription
        self.name = name
        self.number = number
        self.price = price
        self.purchaseDate = purchaseDate
        self.purchaseFrom = purchaseFrom
        self.recordDate = recordDate
    }
}

extension Food: Encodable {
    enum CodingKeys: String, CodingKey {
        case id, bestBefore, brand, category, foodDescription, name, number, price, purchaseDate, purchaseFrom, recordDate
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(bestBefore, forKey: .bestBefore)
        try container.encode(brand, forKey: .brand)
        try container.encode(category, forKey: .category)
        try container.encode(foodDescription, forKey: .foodDescription)
        try container.encode(name, forKey: .name)
        try container.encode(number, forKey: .number)
        try container.encode(price, forKey: .price)
        try container.encode(purchaseDate, forKey: .purchaseDate)
        try container.encode(purchaseFrom, forKey: .purchaseFrom)
        try container.encode(recordDate, forKey: .recordDate)
    }
}

@Model
class Clothing: Identifiable {
    var id = UUID()
    
    var brand: String
    var category: String
    var clothingDescription: String
    var color: String
    var name: String
    var number: Double
    var price: Double
    var priority: Int
    var purchaseDate: Date
    var purchaseFrom: String
    var recordDate: Date
    var season: [String]

    init(id: UUID = UUID(), brand: String, category: String, clothingDescription: String, color: String, name: String, number: Double, price: Double, priority: Int, purchaseDate: Date, purchaseFrom: String, recordDate: Date, season: [String]) {
        self.id = id
        self.brand = brand
        self.category = category
        self.clothingDescription = clothingDescription
        self.color = color
        self.name = name
        self.number = number
        self.price = price
        self.priority = priority
        self.purchaseDate = purchaseDate
        self.purchaseFrom = purchaseFrom
        self.recordDate = recordDate
        self.season = season
    }
}

extension Clothing: Encodable {
    enum CodingKeys: String, CodingKey {
        case id, brand, category, clothingDescription, color, name, number, price, priority, purchaseDate, purchaseFrom, recordDate, season
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(brand, forKey: .brand)
        try container.encode(category, forKey: .category)
        try container.encode(clothingDescription, forKey: .clothingDescription)
        try container.encode(color, forKey: .color)
        try container.encode(name, forKey: .name)
        try container.encode(number, forKey: .number)
        try container.encode(price, forKey: .price)
        try container.encode(priority, forKey: .priority)
        try container.encode(purchaseDate, forKey: .purchaseDate)
        try container.encode(purchaseFrom, forKey: .purchaseFrom)
        try container.encode(recordDate, forKey: .recordDate)
        try container.encode(season, forKey: .season)
    }
}

