import SwiftUI

struct CheckRecentCard: View {
    let messageCount: Int
    let friendAvatarUrls: [String?]

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: BoundSpacing.xs) {
                Text("Check Recent")
                    .font(BoundFont.cardMessage)
                    .foregroundStyle(.white)
                Text("\(messageCount) Messages")
                    .font(BoundFont.caption)
                    .foregroundStyle(BoundColors.textSecondary)
            }

            Spacer()

            AvatarStackView(urls: friendAvatarUrls, size: 48, maxVisible: 4)
        }
        .padding(BoundSpacing.lg)
        .background {
            RoundedRectangle(cornerRadius: BoundRadius.card)
                .fill(BoundColors.surfaceGlass)
                .boundGlass()
                .overlay(
                    RoundedRectangle(cornerRadius: BoundRadius.card)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                )
        }
    }
}

#Preview {
    CheckRecentCard(messageCount: 12, friendAvatarUrls: [nil, nil, nil, nil])
        .padding()
        .background(BoundColors.background)
}
