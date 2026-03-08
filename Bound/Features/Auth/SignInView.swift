import SwiftUI

struct SignInView: View {
    @Bindable var viewModel: AuthViewModel
    let onAuthenticated: () -> Void

    var body: some View {
        VStack(spacing: BoundSpacing.xxl) {
            Spacer()

            VStack(spacing: BoundSpacing.md) {
                Image(systemName: "link.circle.fill")
                    .font(.system(size: 64))
                    .foregroundStyle(BoundColors.accent)

                Text("Bound")
                    .font(BoundFont.largeTitle)
                    .foregroundStyle(.white)

                Text("Send love to your people")
                    .font(BoundFont.body)
                    .foregroundStyle(BoundColors.textSecondary)
            }

            Spacer()

            VStack(spacing: BoundSpacing.lg) {
                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .boundTextField()

                SecureField("Password", text: $viewModel.password)
                    .textContentType(.password)
                    .boundTextField()

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(BoundFont.small)
                        .foregroundStyle(.red)
                }
            }

            Button {
                Task {
                    if await viewModel.signIn() {
                        onAuthenticated()
                    }
                }
            } label: {
                Text(viewModel.isLoading ? "Signing in..." : "Sign In")
                    .font(BoundFont.button)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, BoundSpacing.lg)
                    .background(BoundColors.accent, in: RoundedRectangle(cornerRadius: BoundRadius.md))
            }
            .disabled(!viewModel.canSignIn || viewModel.isLoading)

            Button {
                viewModel.currentScreen = .signUp
                viewModel.errorMessage = nil
            } label: {
                Text("Don't have an account? **Sign Up**")
                    .font(BoundFont.caption)
                    .foregroundStyle(BoundColors.textSecondary)
            }

            Spacer()
        }
        .padding(.horizontal, BoundSpacing.xxl)
    }
}

extension View {
    func boundTextField() -> some View {
        self
            .font(BoundFont.body)
            .foregroundStyle(.white)
            .tint(.white)
            .padding(BoundSpacing.lg)
            .background(Color.white.opacity(0.08), in: RoundedRectangle(cornerRadius: BoundRadius.md))
    }
}

#Preview {
    SignInView(viewModel: AuthViewModel(), onAuthenticated: {})
        .background(BoundColors.background)
}
