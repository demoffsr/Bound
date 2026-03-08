import SwiftUI

@Observable
@MainActor
final class HomeViewModel {
    var messages: [BoundMessage] = []
    var isLoading = false
    var error: Error?
    var replyTarget: BoundMessage?

    var currentUser: BoundUser { PreviewData.currentUser }

    var unreadCount: Int {
        messages.filter { !$0.isRead }.count
    }

    var recentFriendAvatars: [String?] {
        let unique = messages.compactMap(\.sender).uniqued(on: \.id)
        return Array(unique.prefix(3).map(\.avatarUrl))
    }

    func loadMessages() async {
        isLoading = true
        defer { isLoading = false }

        // TODO: Replace with MessageService.fetchMessages() when Supabase is connected
        try? await Task.sleep(for: .milliseconds(300))
        messages = PreviewData.sampleMessages
    }

    func sendReaction(_ type: ReactionType, for message: BoundMessage) async {
        // TODO: Replace with ReactionService.sendReaction()
        print("Reaction \(type.emoji) sent for message \(message.id)")
    }

    func startReply(to message: BoundMessage) {
        replyTarget = message
    }
}

private extension Array {
    func uniqued<T: Hashable>(on keyPath: KeyPath<Element, T>) -> [Element] {
        var seen = Set<T>()
        return filter { seen.insert($0[keyPath: keyPath]).inserted }
    }
}
