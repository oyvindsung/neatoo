import SwiftUI

struct SquareCardView1: View {
    
    let title: String
    let date: Date
    let width = UIScreen.main.bounds.width / 2 - 24
    let onDelete: () -> Void
    
    var calc: (Int, Int) {
        let calendar = Calendar.current
        let timeLeft = calendar.dateComponents([.hour], from: .now, to: date)
        let hour = (timeLeft.hour!) % 24
        let day = Int((timeLeft.hour! - hour) / 24)
        return (day, hour)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
            }
            Spacer()
            if calc.0 == 0 {
                HStack(alignment: .bottom, spacing: 2) {
                    Text("\(calc.1)")
                        .fontWeight(.heavy)
                        .fontWidth(.compressed)
                        .font(.system(size: 66))
                        .foregroundColor(.orange)
                    Text("h")
                        .font(.system(size: 24))
                        .baselineOffset(10)
                        .fontWidth(.compressed)
                        .bold()
                }
            } else {
                HStack(alignment: .bottom, spacing: 2) {
                    Text("\(calc.0)")
                        .fontWeight(.heavy)
                        .fontWidth(.compressed)
                        .font(.system(size: 66))
                        .foregroundColor(.orange)
                    Text("d")
                        .font(.system(size: 24))
                        .baselineOffset(10)
                        .fontWidth(.compressed)
                        .bold()
                }
            }
            Spacer()
        }
        .padding()
        .frame(width: width, height: width)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
        .contextMenu {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("删除", systemImage: "trash")
            }
        }
    }
}

struct SquareCardView2: View {
    
    let title: String
    let date: Date
    let onDelete: () -> Void
    
    let width = UIScreen.main.bounds.width / 2 - 24
    
    var calc: (Int, Int) {
        let calendar = Calendar.current
        let timeLeft = calendar.dateComponents([.hour], from: date, to: .now)
        let hour = (timeLeft.hour!) % 24
        let day = Int((timeLeft.hour! - hour) / 24)
        return (day, hour)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
            }
            Spacer()
            if calc.0 == 0 {
                HStack(alignment: .bottom, spacing: 2) {
                    Text("\(calc.1)")
                        .fontWeight(.heavy)
                        .fontWidth(.compressed)
                        .font(.system(size: 66))
                        .foregroundColor(.green)
                    Text("h")
                        .font(.system(size: 24))
                        .baselineOffset(10)
                        .fontWidth(.compressed)
                        .bold()
                }
            } else {
                HStack(alignment: .bottom, spacing: 2) {
                    Text("\(calc.0)")
                        .fontWeight(.heavy)
                        .fontWidth(.compressed)
                        .font(.system(size: 66))
                        .foregroundColor(.green)
                    Text("d")
                        .font(.system(size: 24))
                        .baselineOffset(10)
                        .fontWidth(.compressed)
                        .bold()
                }
            }
            Spacer()
        }
        .padding()
        .frame(width: width, height: width)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
        .contextMenu {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("删除", systemImage: "trash")
            }
        }
    }
}

//#Preview {
//    SquareCardView1(title: "TTT", date: .now, onDelete: () -> Void)
//}
