//
//  DataModelOfTask.swift
//  neatoo
//
//  Created by song on 2025/6/5.
//

import Foundation
import SwiftData

enum TaskCategory: String, Codable, Identifiable, CaseIterable {
    case learn = "学习"
    case entertainment = "娱乐"
    case work = "工作"
    case rest = "休息"
    case transport = "交通"
    case eating = "饮食"
    case sports = "运动"
    
    var id: String { self.rawValue }
}

@Model
final class Task: Identifiable {
    var id: UUID
    
    var category: TaskCategory
    var endDate: Date
    var name: String
    var priority: Int
    var startDate: Date
    
    var duration: DateComponents {
        Calendar.current.dateComponents([.hour, .minute], from: startDate, to: endDate)
    }

    init(id: UUID = UUID(), category: TaskCategory, endDate: Date, name: String, priority: Int, startDate: Date) {
        self.id = id
        self.category = category
        self.endDate = endDate
        self.name = name
        self.priority = priority
        self.startDate = startDate
    }
}

extension Task: Codable {
    enum CodingKeys: String, CodingKey {
        case id, category, endDate, name, priority, startDate
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(category, forKey: .category)
        try container.encode(endDate, forKey: .endDate)
        try container.encode(name, forKey: .name)
        try container.encode(priority, forKey: .priority)
        try container.encode(startDate, forKey: .startDate)
    }
    
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(UUID.self, forKey: .id)
        let category = try container.decode(TaskCategory.self, forKey: .category)
        let endDate = try container.decode(Date.self, forKey: .endDate)
        let name = try container.decode(String.self, forKey: .name)
        let priority = try container.decode(Int.self, forKey: .priority)
        let startDate = try container.decode(Date.self, forKey: .startDate)
        
        self.init(
            id: id,
            category: category,
            endDate: endDate,
            name: name,
            priority: priority,
            startDate: startDate
        )
    }
}
