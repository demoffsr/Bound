import SwiftUI

struct SignUpView: View {
    @Bindable var viewModel: AuthViewModel

    var body: some View {
        VStack(spacing: BoundSpacing.xxl) {
            Spacer()

            VStack(spacing: BoundSpacing.md) {
                Text("Create Account")
                    .font(BoundFont.largeTitle)
                    .foregroundStyle(.white)

                Text("Join Bound and connect with your people")
                    .font(BoundFont.body)
                    .foregroundStyle(BoundColors.textSecondary)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            VStack(spacing: BoundSpacing.lg) {
                TextField("Your Name", text: $viewModel.displayName)
                    .textContentType(.name)
                    .boundTextField()

                TextField("Email", text: $viewModel.email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .boundTextField()

                SecureField("Password (6+ characters)", text: $viewModel.password)
                    .textContentType(.newPassword)
                    .boundTextField()

                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(BoundFont.small)
                        .foregroundStyle(.red)
                }
            }

            Button {
                Task { await viewModel.signUp() }
            } label: {
                Text(viewModel.isLoading ? "Creating..." : "Create Account")
                    .font(BoundFont.button)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, BoundSpacing.lg)
                    .background(BoundColors.accent, in: RoundedRectangle(cornerRadius: BoundRadius.md))
            }
            .disabled(!viewModel.canSignUp || viewModel.isLoading)

            Button {
                viewModel.currentScreen = .signIn
                viewModel.errorMessage = nil
            } label: {
                Text("Already have an account? **Sign In**")
                    .font(BoundFont.caption)
                    .foregroundStyle(BoundColors.textSecondary)
            }

            Spacer()
        }
        .padding(.horizontal, BoundSpacing.xxl)
    }
}

#Preview {
    SignUpView(viewModel: AuthViewModel())
        .background(BoundColors.background)
}
