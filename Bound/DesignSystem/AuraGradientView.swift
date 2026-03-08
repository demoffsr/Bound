import SwiftUI

struct AuraGradientView: View {
    let aura: AuraGradient

    var body: some View {
        LinearGradient(
            colors: [aura.startColor, aura.endColor],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    AuraGradientView(aura: .bluePurple)
        .frame(width: 300, height: 400)
        .clipShape(RoundedRectangle(cornerRadius: BoundRadius.card))
}
