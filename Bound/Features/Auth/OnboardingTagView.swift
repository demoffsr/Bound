import SwiftUI

struct OnboardingTagView: View {
    @Bindable var viewModel: AuthViewModel
    let onComplete: () -> Void

    var body: some View {
        VStack(spacing: BoundSpacing.xxl) {
            Spacer()

            VStack(spacing: BoundSpacing.md) {
                Image(systemName: "at")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(BoundColors.accent)

                Text("Pick your BoundTag")
                    .font(BoundFont.largeTitle)
                    .foregroundStyle(.white)

                Text("This is how friends will find you")
                    .font(BoundFont.body)
                    .foregroundStyle(BoundColors.textSecondary)
            }

            Spacer()

            VStack(spacing: BoundSpacing.lg) {
                HStack(spacing: 4) {
                    Text("@")
                        .font(BoundFont.tag)
                        .foregroundStyle(BoundColors.textMuted)

                    TextField("your_tag", text: $viewModel.boundTag)
                        .font(BoundFont.tag)
                        .foregroundStyle(.white)
                        .tint(.white)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                }
                .padding(BoundSpacing.lg)
                .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: BoundRadius.md))

                if viewModel.canSetTag {
                    Text("@\(viewModel.boundTag.lowercased()) looks great!")
                        .font(BoundFont.small)
                        .foregroundStyle(.green)
                } else if !viewModel.boundTag.isEmpty {
                    Text("At least 3 characters, letters, numbers, underscores only")
                        .font(BoundFont.small)
                        .foregroundStyle(BoundColors.textMuted)
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(BoundFont.small)
                        .foregroundStyle(.red)
                }
            }

            Button {
                Task {
                    if await viewModel.setTag() {
                        onComplete()
                    }
                }
            } label: {
                Text(viewModel.isLoading ? "Setting up..." : "Let's Go!")
                    .font(BoundFont.button)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, BoundSpacing.lg)
                    .background(BoundColors.accent, in: RoundedRectangle(cornerRadius: BoundRadius.md))
            }
            .disabled(!viewModel.canSetTag || viewModel.isLoading)

            Spacer()
        }
        .padding(.horizontal, BoundSpacing.xxl)
    }
}

#Preview {
    OnboardingTagView(viewModel: AuthViewModel(), onComplete: {})
        .background(BoundColors.background)
}
