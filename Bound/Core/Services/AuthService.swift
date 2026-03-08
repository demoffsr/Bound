import Foundation
import Supabase
import Auth

enum AuthService {

    static func signUp(email: String, password: String) async throws -> User {
        let response = try await supabase.auth.signUp(email: email, password: password)
        return response.user
    }

    static func signIn(email: String, password: String) async throws -> Session {
        try await supabase.auth.signIn(email: email, password: password)
    }

    static func signOut() async throws {
        try await supabase.auth.signOut()
    }

    static func currentSession() async throws -> Session {
        try await supabase.auth.session
    }

    static func currentUserId() async throws -> UUID {
        try await supabase.auth.session.user.id
    }

    static var authStateChanges: AsyncStream<(event: AuthChangeEvent, session: Session?)> {
        AsyncStream { continuation in
            let task = Task {
                for await (event, session) in supabase.auth.authStateChanges {
                    continuation.yield((event: event, session: session))
                }
                continuation.finish()
            }
            continuation.onTermination = { _ in task.cancel() }
        }
    }
}
