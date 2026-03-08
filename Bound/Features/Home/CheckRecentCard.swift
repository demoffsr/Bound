import SwiftUI

struct CheckRecentCard: View {
    let messageCount: Int
    let friendAvatarUrls: [String?]

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: BoundSpacing.xs) {
                Text("Check Recent")
                    .font(BoundFont.headline)
                    .foregroundStyle(.white)
                Text("\(messageCount) Messages")
                    .font(BoundFont.caption)
                    .foregroundStyle(BoundColors.textSecondary)
            }

            Spacer()

            AvatarStackView(urls: friendAvatarUrls, size: 32)
        }
        .padding(BoundSpacing.lg)
        .background(BoundColors.cardBackground, in: RoundedRectangle(cornerRadius: BoundRadius.lg))
    }
}

#Preview {
    CheckRecentCard(messageCount: 12, friendAvatarUrls: [nil, nil, nil])
        .padding()
        .background(BoundColors.background)
}
