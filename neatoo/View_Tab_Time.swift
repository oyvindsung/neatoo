import SwiftUI
import SwiftData

struct TimeView: View {
    @Query private var tasks: [Task]
    
    @Environment(\.modelContext) private var context
    
    @State private var showAddTaskSheet = false
    @State private var isImporting = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TimeChartView()
                CardView(
                    title: "事项",
                    items: tasks.sorted { $0.endDate > $1.endDate },
                    showAddSheet: $showAddTaskSheet,
                    itemName: { $0.name },
                    rowDestination: { task in TaskDetailInfo(task: task) },
                    allItemsView: { AllTaskListView(
                        tasks: tasks,
                        toDetail: { task in TaskDetailInfo(task: task) },
                        delete: { indexSet in
                            for index in indexSet {
                                context.delete(tasks[index])
                            }
                        },
                        filename: "task_data"
                    )
                    .modelContainer(for: Task.self)
                    },
                    addItemView: {
                        AddNewTaskView { newTask in context.insert(newTask) }
                    }
                )
            }
//            .sheet(isPresented: $showAddTaskSheet) {
//                AddNewTaskView { newTask in
//                    context.insert(newTask)
//                }
//            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isImporting = true
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
            }
            .fileImporter(
                isPresented: $isImporting,
                allowedContentTypes: [.json]
            ) { result in
                do {
                    let fileURL = try result.get()
                    guard fileURL.startAccessingSecurityScopedResource() else {
                        print("没有读取权限")
                        return
                    }
                    defer { fileURL.stopAccessingSecurityScopedResource() }
                    
                    let data = try Data(contentsOf: fileURL)
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601

                    let decodedItems = try decoder.decode([Task].self, from: data)
                    for item in decodedItems {
                        withAnimation {
                            context.insert(item)
                        }
                    }
                } catch {
                    print("Import failed: \(error)")
                }
            }
            .navigationTitle("日程")
        }
    }
}

#Preview {
    TimeView()
        .modelContainer(for: [Task.self])
}
