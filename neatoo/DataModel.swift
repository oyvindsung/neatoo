//
//  DataModel.swift
//  neatoo
//
//  Created by song on 2025/5/30.
//

import Foundation
import SwiftData

protocol Categorizable {
    var category: String { get }
}

@Model
final class Ware: Identifiable, Categorizable {
    var id = UUID()
    
    var brand: String
    var category: String
    var name: String
    var number: Int
    var price: Double
    var priority: Int
    var purchaseDate: Date
    var purchaseFrom: String
    var recordDate: Date
    var wareDescription: String

    init(id: UUID = UUID(), brand: String, category: String, name: String, number: Int, price: Double, priority: Int, purchaseDate: Date, purchaseFrom: String, recordDate: Date, wareDescription: String) {
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

extension Ware: Codable {
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

    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(UUID.self, forKey: .id)
        let brand = try container.decode(String.self, forKey: .brand)
        let category = try container.decode(String.self, forKey: .category)
        let name = try container.decode(String.self, forKey: .name)
        let number = try container.decode(Int.self, forKey: .number)
        let price = try container.decode(Double.self, forKey: .price)
        let priority = try container.decode(Int.self, forKey: .priority)
        let purchaseDate = try container.decode(Date.self, forKey: .purchaseDate)
        let purchaseFrom = try container.decode(String.self, forKey: .purchaseFrom)
        let recordDate = try container.decode(Date.self, forKey: .recordDate)
        let wareDescription = try container.decode(String.self, forKey: .wareDescription)

        self.init(
            id: id,
            brand: brand,
            category: category,
            name: name,
            number: number,
            price: price,
            priority: priority,
            purchaseDate: purchaseDate,
            purchaseFrom: purchaseFrom,
            recordDate: recordDate,
            wareDescription: wareDescription
        )
    }
}

@Model
final class Food: Identifiable, Categorizable {
    var id = UUID()
    
    var bestBefore: Date
    var brand: String
    var category: String
    var foodDescription: String
    var name: String
    var number: Int
    var price: Double
    var purchaseDate: Date
    var purchaseFrom: String
    var recordDate: Date
    
    init(id: UUID = UUID(), bestBefore: Date, brand: String, category: String, foodDescription: String, name: String, number: Int, price: Double, purchaseDate: Date, purchaseFrom: String, recordDate: Date) {
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

extension Food: Codable {
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
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(UUID.self, forKey: .id)
        let bestBefore = try container.decode(Date.self, forKey: .bestBefore)
        let brand = try container.decode(String.self, forKey: .brand)
        let category = try container.decode(String.self, forKey: .category)
        let foodDescription = try container.decode(String.self, forKey: .foodDescription)
        let name = try container.decode(String.self, forKey: .name)
        let number = try container.decode(Int.self, forKey: .number)
        let price = try container.decode(Double.self, forKey: .price)
        let purchaseDate = try container.decode(Date.self, forKey: .purchaseDate)
        let purchaseFrom = try container.decode(String.self, forKey: .purchaseFrom)
        let recordDate = try container.decode(Date.self, forKey: .recordDate)

        self.init(
            id: id,
            bestBefore: bestBefore,
            brand: brand,
            category: category,
            foodDescription: foodDescription,
            name: name,
            number: number,
            price: price,
            purchaseDate: purchaseDate,
            purchaseFrom: purchaseFrom,
            recordDate: recordDate
        )
    }
}

@Model
final class Clothing: Identifiable, Categorizable {
    var id = UUID()
    
    var brand: String
    var category: String
    var clothingDescription: String
    var color: String
    var name: String
    var number: Int
    var price: Double
    var priority: Int
    var purchaseDate: Date
    var purchaseFrom: String
    var recordDate: Date
    var seasons: [String]

    init(id: UUID = UUID(), brand: String, category: String, clothingDescription: String, color: String, name: String, number: Int, price: Double, priority: Int, purchaseDate: Date, purchaseFrom: String, recordDate: Date, seasons: [String]) {
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
        self.seasons = seasons
    }
}

extension Clothing: Codable {
    enum CodingKeys: String, CodingKey {
        case id, brand, category, clothingDescription, color, name, number, price, priority, purchaseDate, purchaseFrom, recordDate, seasons
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
        try container.encode(seasons, forKey: .seasons)
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(UUID.self, forKey: .id)
        let brand = try container.decode(String.self, forKey: .brand)
        let category = try container.decode(String.self, forKey: .category)
        let clothingDescription = try container.decode(String.self, forKey: .clothingDescription)
        let color = try container.decode(String.self, forKey: .color)
        let name = try container.decode(String.self, forKey: .name)
        let number = try container.decode(Int.self, forKey: .number)
        let price = try container.decode(Double.self, forKey: .price)
        let priority = try container.decode(Int.self, forKey: .priority)
        let purchaseDate = try container.decode(Date.self, forKey: .purchaseDate)
        let purchaseFrom = try container.decode(String.self, forKey: .purchaseFrom)
        let recordDate = try container.decode(Date.self, forKey: .recordDate)
        let seasons = try container.decode([String].self, forKey: .seasons)

        self.init(
            id: id,
            brand: brand,
            category: category,
            clothingDescription: clothingDescription,
            color: color,
            name: name,
            number: number,
            price: price,
            priority: priority,
            purchaseDate: purchaseDate,
            purchaseFrom: purchaseFrom,
            recordDate: recordDate,
            seasons: seasons
        )
    }
}

