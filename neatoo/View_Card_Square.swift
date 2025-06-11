import SwiftUI

struct SquareCardView1: View {
    
    let title: String
    let date: Date
    let width = UIScreen.main.bounds.width / 2 - 24
    
    var timeLeft: DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: .now, to: date)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
            }
            Spacer()
            Text("\(timeLeft.day ?? 0)")
                .fontWeight(.heavy)
                .fontWidth(.compressed)
                .font(.system(size: 66))
                .foregroundColor(.orange)
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
    }
}

struct SquareCardView2: View {
    
    let title: String
    let date: Date
    let width = UIScreen.main.bounds.width / 2 - 24
    
    var timeLeft: DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: date, to: .now)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
            }
            Spacer()
            Text("\(timeLeft.day ?? 0)")
                .fontWeight(.heavy)
                .fontWidth(.compressed)
                .font(.system(size: 66))
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
    }
}

#Preview {
    SquareCardView1(title: "TTT", date: .now)
}
