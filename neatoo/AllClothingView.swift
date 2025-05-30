import SwiftUI
import SwiftData

struct AllClothingView: View {
    @Query private var clothing: [Clothing]
    
    @Environment(\.modelContext) private var context
    
    @State private var editMode: EditMode = .inactive
    
    @State private var exportData: Data?
    @State private var isExporting: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(clothing, id: \.id) { item in
                    NavigationLink("\(item.name)") {
                        ClothingDetailInfo(clothing: item)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("所有衣物")
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
                        exportClothingToJSON()
                    }
                }
            }
            .fileExporter(
                isPresented: $isExporting,
                document: JSONExportDocument(data: exportData ?? Data()),
                contentType: .json,
                defaultFilename: "clothing_data"
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
            let item = clothing[index]
            context.delete(item)
        }
    }
    
    func exportClothingToJSON() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            encoder.dateEncodingStrategy = .iso8601
            
            let jsonData = try encoder.encode(clothing)
            exportData = jsonData
            isExporting = true
        } catch {
            print("Failed to encode food data: \(error.localizedDescription)")
        }
    }
}
