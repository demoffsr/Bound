import SwiftUI

struct PillButton: View {
    let title: String
    var icon: String? = nil
    var style: PillButtonStyle = .primary
    let action: () -> Void

    enum PillButtonStyle {
        case primary
        case glass
        case subtle

        var background: some ShapeStyle {
            switch self {
            case .primary: AnyShapeStyle(Color.white.opacity(0.2))
            case .glass: AnyShapeStyle(.ultraThinMaterial)
            case .subtle: AnyShapeStyle(Color.white.opacity(0.1))
            }
        }
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: BoundSpacing.sm) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .semibold))
                }
                Text(title)
                    .font(BoundFont.button)
            }
            .foregroundStyle(.white)
            .padding(.horizontal, BoundSpacing.xl)
            .padding(.vertical, BoundSpacing.md)
            .background(style.background, in: Capsule())
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        PillButton(title: "Write Back", style: .primary) {}
        PillButton(title: "Bound To", icon: "link", style: .glass) {}
        PillButton(title: "Send", style: .subtle) {}
    }
    .padding()
    .background(BoundColors.background)
}
