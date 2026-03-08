import SwiftUI

struct BoundTabBar: View {
    var body: some View {
        HStack {
            Spacer()
            Button(action: {}) {
                HStack(spacing: BoundSpacing.sm) {
                    Image(systemName: "link")
                        .font(.system(size: 16, weight: .semibold))
                    Text("Bound To")
                        .font(BoundFont.button)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, BoundSpacing.xxl)
                .padding(.vertical, BoundSpacing.md)
                .background(.ultraThinMaterial, in: Capsule())
            }
            Spacer()
        }
        .padding(.bottom, BoundSpacing.sm)
    }
}

#Preview {
    BoundTabBar()
        .background(BoundColors.background)
}
