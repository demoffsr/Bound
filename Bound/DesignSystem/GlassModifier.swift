import SwiftUI

struct BoundGlassModifier: ViewModifier {
    var tintOpacity: Double = 0.1

    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .background(Color.white.opacity(tintOpacity))
    }
}

extension View {
    func boundGlass(tintOpacity: Double = 0.1) -> some View {
        modifier(BoundGlassModifier(tintOpacity: tintOpacity))
    }
}
