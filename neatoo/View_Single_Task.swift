//
//  SingleTaskDetialInfo.swift
//  neatoo
//
//  Created by song on 2025/6/6.
//

import SwiftUI
import SwiftData

struct TaskDetailInfo: View {
    let task: Task
    
    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        return dateFormatter
    }
    
    private var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }

    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Text("ID")
                    Spacer()
                    Text("\(task.id)")
                }
                HStack {
                    Text("名称")
                    Spacer()
                    Text("\(task.name)")
                }
                HStack {
                    Text("类别")
                    Spacer()
                    Text("\(task.category.rawValue)")
                }
                HStack {
                    Text("重要性")
                    Spacer()
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= task.priority ? "star.fill" : "star")
                            .foregroundColor(.accent)
                    }
                }
                HStack {
                    Text("开始时间")
                    Spacer()
                    Text(dateFormatter.string(from: task.startDate))
                }
                HStack {
                    Text("结束时间")
                    Spacer()
                    Text(dateFormatter.string(from: task.endDate))
                }
                HStack {
                    Text("持续时间")
                    Spacer()
                    Text("\(task.duration.hour ?? 0) 小时 \(task.duration.minute ?? 0) 分钟")
                }
            }
        }
    }
}
