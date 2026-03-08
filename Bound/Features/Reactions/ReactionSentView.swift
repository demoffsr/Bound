import SwiftUI

struct ReactionSentView: View {
    var body: some View {
        Text("Reaction Sent!")
            .font(BoundFont.button)
            .foregroundStyle(.white)
            .padding(.horizontal, BoundSpacing.xl)
            .padding(.vertical, BoundSpacing.md)
            .background(.white.opacity(0.2), in: Capsule())
    }
}

#Preview {
    ReactionSentView()
        .padding()
        .background(AuraGradient.bluePurple.gradient)
}
