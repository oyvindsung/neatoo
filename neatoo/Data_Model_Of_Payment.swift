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

struct Account: Codable {
    var ID: String
    var bank: String
    var balance: Double
    var name: String
    
    init(ID: String, bank: String, balance: Double, name: String) {
        self.ID = ID
        self.bank = bank
        self.balance = balance
        self.name = name
    }
}

@Model
final class Payment: Identifiable {
    var id: UUID = UUID()
    
    var account: Account
    var amount: Double
    var category: PaymentCategory
    var how: String
    var name: String
    var priority: Int
    var date: Date

    init(id: UUID = UUID(), account: Account, amount: Double, category: PaymentCategory, date: Date, how: String, name: String, priority: Int) {
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
        let account = try container.decode(Account.self, forKey: .account)
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
