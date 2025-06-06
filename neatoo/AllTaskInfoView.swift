//
//  AllWarehouseInfoView.swift
//  neatoo
//
//  Created by song on 2025/6/2.
//

import SwiftUI
import SwiftData

struct AllTaskListView<DetailView: View>: View {
    //MARK: - parameters
    @Query private var tasks: [Task]
    
    @Environment(\.modelContext) private var context
    
    let toDetail: (Task) -> DetailView
    let delete: (IndexSet) -> Void
    let filename: String
    
    @State private var editMode: EditMode = .inactive
    @State private var exportData: Data?
    @State private var isExporting = false
    @State private var selectedCategory: String = "全部"

    var categories: [String] {
        let all = tasks.map(\.category.rawValue)
        return ["全部"] + Array(Set(all)).sorted()
    }
    
    var filteredTasks: [Task] {
        if selectedCategory == "全部" {
            return tasks
        } else {
            return tasks.filter { $0.category.rawValue == selectedCategory }
        }
    }
    
    var totalHoursAndMinutes: (Int, Int) {
        var hours = 0
        var minutes = 0
        
        for task in filteredTasks {
            hours += task.duration.hour ?? 0
            minutes += task.duration.minute ?? 0
        }
        
        hours += minutes / 60
        minutes = minutes % 60
        
        return (hours, minutes)
    }
    
    // MARK: - functions
    private func exportTasks() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            encoder.dateEncodingStrategy = .iso8601
            exportData = try encoder.encode(tasks)
            isExporting = true
        } catch {
            print("Export failed: \(error)")
        }
    }
    
    // MARK: - view
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Picker("筛选", selection: $selectedCategory) {
                            ForEach(categories, id: \.self) { cat in
                                Text(cat).tag(cat)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        Spacer()
                    }
                    .padding(.horizontal)
                    .listRowInsets(EdgeInsets())
                }
                Section {
                    ForEach(filteredTasks) { task in
                        NavigationLink("\(task.name)") {
                            toDetail(task)
                        }
                    }
                    .onDelete(perform: delete)
                    .padding(.horizontal)
                }
                .listRowInsets(EdgeInsets())
                Section {
                    Text("共 \(totalHoursAndMinutes.0) 小时 \(totalHoursAndMinutes.1) 分钟")
                        .listRowInsets(EdgeInsets())
                        .padding(.horizontal)
                }
            }
            .listSectionSpacing(12)
            .navigationTitle("所有事项")
            .navigationBarTitleDisplayMode(.inline)
            .environment(\.editMode, $editMode)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        withAnimation(.easeInOut) {
                            editMode = editMode == .active ? .inactive : .active
                        }
                    } label: {
                        Image(systemName: editMode == .active ? "checkmark" : "pencil")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        exportTasks()
                    } label: {
                        Image(systemName: "square.and.arrow.down")
                    }
                }
            }
            .fileExporter(
                isPresented: $isExporting,
                document: JSONExportDocument(data: exportData ?? Data()),
                contentType: .json,
                defaultFilename: filename
            ) { result in
                if case let .failure(error) = result {
                    print("Export failed: \(error.localizedDescription)")
                }
            }
        }
    }
}
