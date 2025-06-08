import SwiftUI
import SwiftData

struct AddNewPaymentView: View {
    @Environment(\.dismiss) private var dismiss

//    var bank: String
//    var balance: Double
//    var name: String
    
//    var account: Account
//    var amount: Double
//    var category: PaymentCategory
//    var how: String
//    var name: String
//    var priority: Int
//    var date: Date
    
    @State private var account
    @State private var category: PaymentCategory = .education
    @State private var date: Date = .now
    @State private var name: String = ""
    @State private var priority: Int = 0
    
    
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
                        Text(task.rawValue).tag(task)
                    }
                }
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
                    Text("持续时间")
                    Spacer()
                    if duration.hour != 0 {
                        Text("\(duration.hour ?? 0) 小时 \(duration.minute ?? 0) m")
                    } else {
                        Text("\(duration.minute ?? 0) 分钟")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") {
                        let task = Task(category: category, endDate: endDate, name: name, priority: priority, startDate: startDate)
                        onAdd(task)
                        
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddNewPaymentView { payment in
        print("新任务：\(payment.name)，开始于 \(payment.date)")
    }
}
