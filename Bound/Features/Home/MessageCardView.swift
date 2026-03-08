import SwiftUI

struct MessageCardView: View {
    let message: BoundMessage
    var onWriteBack: () -> Void = {}
    var onReaction: (ReactionType) -> Void = { _ in }

    @State private var showReactionBar = false
    @State private var reactionSent = false

    var body: some View {
        ZStack(alignment: .bottom) {
            // Aura gradient background
            message.aura.gradient
                .overlay {
                    RadialGradient(
                        colors: [.white.opacity(0.15), .clear],
                        center: .center,
                        startRadius: 20,
                        endRadius: 200
                    )
                }

            // Content
            VStack(spacing: BoundSpacing.lg) {
                // Sender tag + timestamp
                senderTag
                    .frame(maxWidth: .infinity, alignment: .center)

                Spacer()

                // Avatar
                AvatarView(url: message.sender?.avatarUrl, size: 56)

                // Message body
                Text(message.body)
                    .font(BoundFont.cardMessage)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(4)

                // Sender name
                Text(message.sender?.displayName ?? "Unknown")
                    .font(BoundFont.caption)
                    .foregroundStyle(.white.opacity(0.8))

                Spacer()

                // Bottom actions
                bottomActions
            }
            .padding(BoundSpacing.xl)
        }
        .frame(height: 320)
        .clipShape(RoundedRectangle(cornerRadius: BoundRadius.card))
    }

    // MARK: - Sender Tag

    private var senderTag: some View {
        Text("@\(message.sender?.boundTag ?? "unknown") \u{2022} \(message.createdAt.boundFormatted)")
            .font(BoundFont.small)
            .foregroundStyle(.white.opacity(0.9))
            .padding(.horizontal, BoundSpacing.md)
            .padding(.vertical, BoundSpacing.xs)
            .background(.white.opacity(0.15), in: Capsule())
    }

    // MARK: - Bottom Actions

    @ViewBuilder
    private var bottomActions: some View {
        if showReactionBar {
            ReactionBarView(
                onReact: { type in
                    withAnimation(.spring(duration: 0.3)) {
                        showReactionBar = false
                        reactionSent = true
                    }
                    onReaction(type)
                    BoundHaptics.success()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation(.easeOut(duration: 0.3)) {
                            reactionSent = false
                        }
                    }
                },
                onClose: {
                    withAnimation(.spring(duration: 0.3)) {
                        showReactionBar = false
                    }
                }
            )
            .transition(.scale.combined(with: .opacity))
        } else if reactionSent {
            HStack(spacing: BoundSpacing.md) {
                emojiButton
                ReactionSentView()
            }
            .transition(.scale.combined(with: .opacity))
        } else {
            HStack(spacing: BoundSpacing.md) {
                emojiButton
                PillButton(title: "Write Back", style: .primary, action: onWriteBack)
            }
            .transition(.scale.combined(with: .opacity))
        }
    }

    private var emojiButton: some View {
        Button {
            withAnimation(.spring(duration: 0.3)) {
                showReactionBar = true
            }
            BoundHaptics.light()
        } label: {
            Image(systemName: "face.smiling")
                .font(.system(size: 20))
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
                .background(.white.opacity(0.2), in: Circle())
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16) {
            MessageCardView(message: PreviewData.sampleMessages[0])
            MessageCardView(message: PreviewData.sampleMessages[1])
            MessageCardView(message: PreviewData.sampleMessages[2])
        }
        .padding()
    }
    .background(BoundColors.background)
}
