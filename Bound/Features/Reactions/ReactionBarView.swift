import SwiftUI

struct ReactionBarView: View {
    let onReact: (ReactionType) -> Void
    let onClose: () -> Void

    var body: some View {
        HStack(spacing: BoundSpacing.md) {
            Button {
                onClose()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.8))
                    .frame(width: 36, height: 36)
                    .background(.white.opacity(0.15), in: Circle())
            }

            ForEach(ReactionType.allCases, id: \.self) { reaction in
                Button {
                    onReact(reaction)
                } label: {
                    Text(reaction.emoji)
                        .font(.system(size: 24))
                        .frame(width: 36, height: 36)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, BoundSpacing.lg)
        .padding(.vertical, BoundSpacing.sm)
    }
}

#Preview {
    ReactionBarView(onReact: { _ in }, onClose: {})
        .background(AuraGradient.bluePurple.gradient)
}
