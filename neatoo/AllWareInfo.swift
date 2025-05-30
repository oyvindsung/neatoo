import SwiftUI
import SwiftData

struct AllWareView: View {
    @Query private var ware: [Ware]
    
    @Environment(\.modelContext) private var context
    
    @State private var editMode: EditMode = .inactive
    
    @State private var exportData: Data?
    @State private var isExporting: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(ware, id: \.id) { item in
                    NavigationLink("\(item.name)") {
                        WareDetailInfo(ware: item)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("所有杂物")
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
                        exportWareToJSON()
                    }
                }
            }
            .fileExporter(
                isPresented: $isExporting,
                document: JSONExportDocument(data: exportData ?? Data()),
                contentType: .json,
                defaultFilename: "ware_data"
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
            let item = ware[index]
            context.delete(item)
        }
    }
    
    func exportWareToJSON() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
            encoder.dateEncodingStrategy = .iso8601
            
            let jsonData = try encoder.encode(ware)
            exportData = jsonData
            isExporting = true
        } catch {
            print("Failed to encode food data: \(error.localizedDescription)")
        }
    }
}
