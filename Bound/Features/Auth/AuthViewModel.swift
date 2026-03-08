import SwiftUI
import Auth

enum AuthScreen {
    case signIn
    case signUp
    case onboardingTag
}

@Observable
@MainActor
final class AuthViewModel {
    var email = ""
    var password = ""
    var displayName = ""
    var boundTag = ""

    var isLoading = false
    var errorMessage: String?

    var currentScreen: AuthScreen = .signIn

    var canSignIn: Bool {
        !email.isEmpty && password.count >= 6
    }

    var canSignUp: Bool {
        !email.isEmpty && password.count >= 6 && !displayName.isEmpty
    }

    var canSetTag: Bool {
        boundTag.count >= 3 && boundTag.allSatisfy { $0.isLetter || $0.isNumber || $0 == "_" }
    }

    func signIn() async -> Bool {
        guard canSignIn else { return false }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            _ = try await AuthService.signIn(email: email, password: password)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func signUp() async -> Bool {
        guard canSignUp else { return false }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            _ = try await AuthService.signUp(email: email, password: password)
            currentScreen = .onboardingTag
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func setTag() async -> Bool {
        guard canSetTag else { return false }
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let userId = try await AuthService.currentUserId()
            try await UserService.updateProfile(
                id: userId,
                boundTag: boundTag.lowercased(),
                displayName: displayName
            )
            return true
        } catch {
            errorMessage = "This tag might already be taken. Try another one."
            return false
        }
    }
}
