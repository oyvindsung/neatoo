import SwiftUI
import SwiftData


struct CountingView: View {
//    @Query private var counting: [Counting]
    
    let counting: [Counting]
    
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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("倒数日")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding(.horizontal)
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(seperate.1.sorted(by: { $0.date < $1.date })) { item in
                            SquareCardView1(title: item.name, date: item.date)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
                VStack {
                    HStack {
                        Text("正数日")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                    .padding(.horizontal)
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(seperate.0.sorted(by: { $0.date > $1.date })) { item in
                            SquareCardView2(title: item.name, date: item.date)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    CountingView(counting: [Counting(date: Date().addingTimeInterval(86400 * 12), name: "Test"), Counting(date: Date().addingTimeInterval(86400 * 52), name: "Test"), Counting(date: Date().addingTimeInterval(86400 * 72), name: "Test"), Counting(date: Date(timeIntervalSince1970: 1743894000), name: "认识响响")])
}
