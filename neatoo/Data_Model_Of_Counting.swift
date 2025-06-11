import Foundation
import SwiftData

@Model
final class Counting: Identifiable {
    var id: UUID
    var date: Date
    var name: String
    
    init(id: UUID = UUID(), date: Date, name: String) {
        self.id = id
        self.date = date
        self.name = name
    }
}

extension Counting: Codable {
    enum CodingKeys: String, CodingKey {
        case id, date, name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(name, forKey: .name)
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(UUID.self, forKey: .id)
        let date = try container.decode(Date.self, forKey: .date)
        let name = try container.decode(String.self, forKey: .name)
        
        self.init(
            id: id,
            date: date,
            name: name
        )
    }
}
