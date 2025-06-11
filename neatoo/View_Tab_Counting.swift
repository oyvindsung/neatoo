import SwiftUI
import SwiftData


struct CountingView: View {
    @Query private var counting: [Counting]
    
    @Environment(\.modelContext) private var context
    
    @State private var showAddNewCounting = false 
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var seperate: ([Counting], [Counting]) {
        var before: [Counting] = []
        var after: [Counting] = []
        for item in counting {
            if item.date > .now {
                after.append(item)
            } else {
                before.append(item)
            }
        }
        return (before, after)
    }
    
    private func delete(_ item: Counting) {
        context.delete(item)
        try? context.save()
    }

    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("倒数日")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding(.horizontal)
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(seperate.1.sorted(by: { $0.date < $1.date })) { item in
                            SquareCardView1(title: item.name, date: item.date) {
                                delete(item)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
                VStack {
                    HStack {
                        Text("正数日")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding(.horizontal)
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(seperate.0.sorted(by: { $0.date > $1.date })) { item in
                            SquareCardView2(title: item.name, date: item.date) {
                                delete(item)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showAddNewCounting = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.accent)
                    }
                }
            }
            .sheet(isPresented: $showAddNewCounting) {
                AddNewCounting()
            }
        }
    }
}

#Preview {
//    CountingView(counting: [Counting(date: Date().addingTimeInterval(86400 * 12), name: "Test"), Counting(date: Date().addingTimeInterval(86400 * 52), name: "Test"), Counting(date: Date().addingTimeInterval(86400 * 72), name: "Test"), Counting(date: Date(timeIntervalSince1970: 1627776000), name: "认识谢经祥"), Counting(date: Date(timeIntervalSince1970: 1023840000), name: "我已经活了")])
    CountingView()
        .modelContainer(for: [Counting.self])
}
