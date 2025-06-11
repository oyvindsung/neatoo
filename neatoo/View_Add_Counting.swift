import SwiftUI
import SwiftData

struct AddNewCounting: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var date: Date = .now
    @State private var name: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                // name
                TextField("名称", text: $name)
                // date
                HStack {
                    Text("计数日期")
                    Spacer()
                    DatePicker(selection: $date) {
                        Text("")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("完成") {
                        let counting = Counting(date: date, name: name)
                        context.insert(counting)
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddNewCounting()
}
