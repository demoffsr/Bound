import SwiftUI

struct AuthGateView: View {
    @State private var isAuthenticated = false
    @State private var isCheckingSession = true
    @State private var authViewModel = AuthViewModel()

    var body: some View {
        Group {
            if isCheckingSession {
                splashView
            } else if isAuthenticated {
                HomeView()
            } else {
                authFlow
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isAuthenticated)
        .animation(.easeInOut(duration: 0.3), value: isCheckingSession)
        .task {
            await checkSession()
        }
    }

    private var splashView: some View {
        VStack {
            Image(systemName: "link.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(BoundColors.accent)
            Text("Bound")
                .font(BoundFont.largeTitle)
                .foregroundStyle(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(BoundColors.background)
    }

    private var authFlow: some View {
        Group {
            switch authViewModel.currentScreen {
            case .signIn:
                SignInView(viewModel: authViewModel) {
                    withAnimation { isAuthenticated = true }
                }
            case .signUp:
                SignUpView(viewModel: authViewModel)
            case .onboardingTag:
                OnboardingTagView(viewModel: authViewModel) {
                    withAnimation { isAuthenticated = true }
                }
            }
        }
        .background(BoundColors.background)
    }

    private func checkSession() async {
        defer { isCheckingSession = false }
        do {
            _ = try await AuthService.currentSession()
            isAuthenticated = true
        } catch {
            isAuthenticated = false
        }
    }
}

#Preview {
    AuthGateView()
}
