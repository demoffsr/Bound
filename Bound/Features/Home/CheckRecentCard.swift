import SwiftUI

struct CheckRecentCard: View {
    let messageCount: Int
    let friendAvatarUrls: [String?]

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: BoundSpacing.xs) {
                Text("Recent Messages")
                    .font(BoundFont.headline)
                    .foregroundStyle(.white)
                Text("\(messageCount) Messages")
                    .font(BoundFont.caption)
                    .foregroundStyle(Color.white.opacity(0.5))
            }

            Spacer()

            AvatarStackView(
                urls: friendAvatarUrls,
                size: 36,
                maxVisible: 4,
                borderColor: .white.opacity(0.4),
                borderWidth: 1,
                showShadow: true,
                overlapFraction: 0.39
            )
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(red: 0.18, green: 0.18, blue: 0.18))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 0.5)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        )
    }
}

#Preview {
    CheckRecentCard(messageCount: 12, friendAvatarUrls: [nil, nil, nil, nil])
        .padding()
        .background(BoundColors.background)
}
