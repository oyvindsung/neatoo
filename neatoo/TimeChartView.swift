//
//  WarehouseChartView.swift
//  neatoo
//
//  Created by song on 2025/6/4.
//

import SwiftUI
import SwiftData
import Charts

struct TaskChartCategory: Identifiable {
    var category: String
    var number: Int
    var id = UUID()
}

struct TimeChartView: View {
    @Query private var tasks: [Task]
    
    @Environment(\.modelContext) private var context
    
    let categoryColors: [String: Color] = [
        "学习": .red,
        "娱乐": .orange,
        "睡眠": .yellow,
        "休息": .green,
        "交通": .blue,
        "饮食": .purple,
        "运动": .pink
    ]
    
    private var taskData: [TaskChartCategory] {
        var categories: [String: Int] = ["学习": 0, "娱乐": 0, "睡眠": 0, "休息": 0, "交通": 0, "饮食": 0, "运动": 0]
        
        for task in tasks {
            let taskDuration = (task.duration.hour ?? 0) * 60 + (task.duration.minute ?? 0)
            categories[task.category.rawValue, default: 0] += taskDuration
        }
        
        return categories.map { TaskChartCategory(category: $0.key, number: $0.value / 60) }
    }
    
    var body: some View {
        Chart {
            ForEach(taskData.sorted(by: { $0.number > $1.number })) { data in
                    BarMark(
                        x: .value("类别", data.category),
                        y: .value("数量", data.number)
                    )
                    .foregroundStyle(categoryColors[data.category] ?? .gray)
                }
        }
        .frame(height: 300)
        .padding()
    }
}

#Preview {
    TimeChartView()
        .modelContainer(for: [Task.self])
}
