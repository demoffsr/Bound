import SwiftUI

struct MessageCardView: View {
    let message: BoundMessage
    var onWriteBack: () -> Void = {}
    var onReaction: (ReactionType) -> Void = { _ in }

    @State private var showReactionBar = false
    @State private var reactionSent = false

    var body: some View {
        ZStack(alignment: .bottom) {
            // Base background
            Color.white.opacity(0.1)

            // Blurred aura circles (diagonal: same color top-left↔bottom-right, top-right↔bottom-left)
            Canvas { context, size in
                let w = size.width
                let h = size.height

                // Top-left: startColor
                let tl = Path(ellipseIn: CGRect(x: -w * 0.15, y: -h * 0.15, width: w * 0.75, height: h * 0.65))
                context.fill(tl, with: .color(message.aura.startColor))

                // Top-right: endColor
                let tr = Path(ellipseIn: CGRect(x: w * 0.4, y: -h * 0.15, width: w * 0.75, height: h * 0.65))
                context.fill(tr, with: .color(message.aura.endColor))

                // Bottom-left: endColor
                let bl = Path(ellipseIn: CGRect(x: -w * 0.15, y: h * 0.5, width: w * 0.75, height: h * 0.65))
                context.fill(bl, with: .color(message.aura.endColor))

                // Bottom-right: startColor
                let br = Path(ellipseIn: CGRect(x: w * 0.4, y: h * 0.5, width: w * 0.75, height: h * 0.65))
                context.fill(br, with: .color(message.aura.startColor))
            }
            .blur(radius: 50)
            .scaleEffect(1.5)  // scale up so blurred edges don't reveal base

            // Content
            VStack(spacing: BoundSpacing.lg) {
                // Sender tag + timestamp
                senderTag
                    .frame(maxWidth: .infinity, alignment: .center)

                Spacer()

                // Avatar
                AvatarView(
                    url: message.sender?.avatarUrl,
                    size: 64,
                    borderColor: .white.opacity(0.2),
                    borderWidth: 1.7
                )

                // Message body
                Text(message.body)
                    .font(BoundFont.cardMessage)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(4)

                // Sender name
                Text(message.sender?.displayName ?? "Unknown")
                    .font(BoundFont.senderName)
                    .foregroundStyle(.white.opacity(0.7))

                Spacer()

                // Bottom actions
                GlassEffectContainer(spacing: BoundSpacing.md) {
                    bottomActions
                }
            }
            .padding(18)
        }
        .frame(height: 380)
        .clipShape(RoundedRectangle(cornerRadius: BoundRadius.card))
        .overlay {
            RoundedRectangle(cornerRadius: BoundRadius.card)
                .stroke(.white.opacity(0.2), lineWidth: 1)
        }
    }

    // MARK: - Sender Tag

    private var senderTag: some View {
        Text("@\(message.sender?.boundTag ?? "unknown") \u{2022} \(message.createdAt.boundFormatted)")
            .font(BoundFont.caption)
            .foregroundStyle(.white.opacity(0.9))
            .padding(.horizontal, BoundSpacing.md)
            .padding(.vertical, BoundSpacing.sm)
            .glassEffect(.regular.tint(.white.opacity(0.25)).interactive(), in: .capsule)
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
                writeBackButton
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
                .font(.system(size: 22))
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .glassEffect(.regular.tint(.white.opacity(0.25)).interactive(), in: .circle)
        }
    }

    private var writeBackButton: some View {
        Button(action: onWriteBack) {
            Text("Write Back")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 198, height: 48)
                .glassEffect(.regular.tint(.white.opacity(0.25)).interactive(), in: .capsule)
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
