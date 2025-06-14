import Foundation
import SwiftData

enum PaymentCategory: String, Codable, Identifiable, CaseIterable {
    case clothing = "衣"
    case food = "食"
    case rent = "住"
    case transportation = "行"
    case education = "教育"
    case daily = "日用"
    case entertainment = "娱乐"
    
    var id: String { self.rawValue }
}

enum IncomeCategory: String, Codable, Identifiable, CaseIterable {
    case job = "工作"
    case scholarship = "奖学金"
    case parents = "家庭补贴"
    case others = "其他"
    
    var id: String { self.rawValue }
}

@Model
final class Account: Identifiable {
    var id: UUID
    var serial: String
    var bank: String
    var balance: Double
    var name: String
    var type: String
    
    init(id: UUID = UUID(), serial: String, bank: String, balance: Double, name: String, type: String) {
        self.id = id
        self.serial = serial
        self.bank = bank
        self.balance = balance
        self.name = name
        self.type = type
    }
}

extension Account: Codable {
    enum CodingKeys: String, CodingKey {
        case id, serial, bank, balance, name, type
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(serial, forKey: .serial)
        try container.encode(bank, forKey: .bank)
        try container.encode(balance, forKey: .balance)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(UUID.self, forKey: .id)
        let serial = try container.decode(String.self, forKey: .serial)
        let bank = try container.decode(String.self, forKey: .bank)
        let balance = try container.decode(Double.self, forKey: .balance)
        let name = try container.decode(String.self, forKey: .name)
        let type = try container.decode(String.self, forKey: .type)
        
        self.init(
            id: id,
            serial: serial,
            bank: bank,
            balance: balance,
            name: name,
            type: type
        )
    }
}

@Model
final class Payment: Identifiable {
    var id: UUID
    
    var account: String
    var amount: Double
    var category: PaymentCategory
    var date: Date
    var how: String
    var name: String
    var priority: Int

    init(id: UUID = UUID(), account: String, amount: Double, category: PaymentCategory, date: Date, how: String, name: String, priority: Int) {
        self.id = id
        self.account = account
        self.amount = amount
        self.category = category
        self.date = date
        self.how = how
        self.name = name
        self.priority = priority
    }
}

extension Payment: Codable {
    enum CodingKeys: String, CodingKey {
        case id, account, amount, category, date, how, name, priority
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(account, forKey: .account)
        try container.encode(amount, forKey: .amount)
        try container.encode(category, forKey: .category)
        try container.encode(date, forKey: .date)
        try container.encode(how, forKey: .how)
        try container.encode(name, forKey: .name)
        try container.encode(priority, forKey: .priority)
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(UUID.self, forKey: .id)
        let account = try container.decode(String.self, forKey: .account)
        let amount = try container.decode(Double.self, forKey: .amount)
        let category = try container.decode(PaymentCategory.self, forKey: .category)
        let date = try container.decode(Date.self, forKey: .date)
        let how = try container.decode(String.self, forKey: .how)
        let name = try container.decode(String.self, forKey: .name)
        let priority = try container.decode(Int.self, forKey: .priority)
        
        self.init(
            id: id,
            account: account,
            amount: amount,
            category: category,
            date: date,
            how: how,
            name: name,
            priority: priority
        )
    }
}

@Model
final class Income: Identifiable {
    var id: UUID
    
    var account: String
    var amount: Double
    var category: IncomeCategory
    var date: Date
    var name: String

    init(id: UUID = UUID(), account: String, amount: Double, category: IncomeCategory, date: Date, name: String) {
        self.id = id
        self.account = account
        self.amount = amount
        self.category = category
        self.date = date
        self.name = name
    }
}

extension Income: Codable {
    enum CodingKeys: String, CodingKey {
        case id, account, amount, category, date, name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(account, forKey: .account)
        try container.encode(amount, forKey: .amount)
        try container.encode(category, forKey: .category)
        try container.encode(date, forKey: .date)
        try container.encode(name, forKey: .name)
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(UUID.self, forKey: .id)
        let account = try container.decode(String.self, forKey: .account)
        let amount = try container.decode(Double.self, forKey: .amount)
        let category = try container.decode(IncomeCategory.self, forKey: .category)
        let date = try container.decode(Date.self, forKey: .date)
        let name = try container.decode(String.self, forKey: .name)
        
        self.init(
            id: id,
            account: account,
            amount: amount,
            category: category,
            date: date,
            name: name
        )
    }
}
