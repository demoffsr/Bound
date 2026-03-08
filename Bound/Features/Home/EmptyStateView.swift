import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: BoundSpacing.sm) {
            Text("Nothing yet.")
                .font(BoundFont.title)
                .foregroundStyle(.white)

            Text("But you could change that.")
                .font(BoundFont.body)
                .foregroundStyle(BoundColors.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 80)
    }
}

#Preview {
    EmptyStateView()
        .background(BoundColors.background)
}
