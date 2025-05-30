import SwiftUI
import SwiftData

struct AllFoodView: View {
    @Query private var food: [Food]
    
    @Environment(\.modelContext) private var context
    
    @State private var editMode: EditMode = .inactive
    // 用于 FileExporter
    @State private var exportData: Data?
    @State private var isExporting: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(food, id: \.id) { item in
                    NavigationLink("\(item.name)") {
                        FoodDetailInfo(food: item)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("所有食物")
            .environment(\.editMode, $editMode)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(editMode == .active ? "完成" : "编辑") {
                        withAnimation(.easeInOut) {
                            editMode = editMode == .active ? .inactive : .active
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("导出") {
                        exportFoodToJSON()
                    }
                }
            }
            .fileExporter(
                isPresented: $isExporting,
                document: JSONExportDocument(data: exportData ?? Data()),
                contentType: .json,
                defaultFilename: "food_data"
            ) { result in
                switch result {
                case .success:
                    print("Export success")
                case .failure(let error):
                    print("Export failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = food[index]
            context.delete(item)
        }
    }
    
    func exportFoodToJSON() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            encoder.dateEncodingStrategy = .iso8601
            
            let jsonData = try encoder.encode(food)
            exportData = jsonData
            isExporting = true
        } catch {
            print("Failed to encode food data: \(error.localizedDescription)")
        }
    }
}
