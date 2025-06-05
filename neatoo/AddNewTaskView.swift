//
//  AddNewTaskView.swift
//  neatoo
//
//  Created by song on 2025/6/5.
//

import SwiftUI
import SwiftData

struct AddNewTaskView: View {
    @Environment(\.dismiss) private var dismiss
    
    // food var
    //    var category: [TaskCategory]
    //    var duration: DateComponents {
    //        return calc()
    //    }
    //    var endDate: Date
    //    var name: String
    //    var priority: Int
    //    var startDate: Date
    
    @State private var category: TaskCategory = .learn
    @State private var endDate: Date = .now
    @State private var name: String = ""
    @State private var priority: Int = 0
    @State private var startDate: Date = .now
    
    var onAdd: (Task) -> Void
    
    var duration: DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.hour, .minute], from: startDate, to: endDate)
    }

    
    var body: some View {
        NavigationStack {
            Form {
                // name
                TextField("名称", text: $name)
                // category
                Picker("类别", selection: $category) {
                    ForEach(TaskCategory.allCases) { task in
                        Text("\(task)").tag(task)
                    }
                }
                // startDate
                HStack {
                    Text("开始时间")
                    Spacer()
                    DatePicker(selection: $startDate) {
                        Text("")
                    }
                }
                // endDate
                HStack {
                    Text("结束时间")
                    Spacer()
                    DatePicker(selection: $endDate) {
                        Text("")
                    }
                }
                // duration
                HStack {
                    Text("")
                    Spacer()
                    Text("\(String(describing: duration.hour))" + " h " + "\(String(description: duration.minute))" + "m")
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") {
                        let task = Task(category: category, endDate: endDate, name: name, priority: priority, startDate: startDate)
                        onAdd(task)
                        
                        dismiss()
                    }
                    .disabled(name.isEmpty || category.rawValue == "")
                }
            }
        }
    }
}

#Preview {
    AddNewTaskView()
}
