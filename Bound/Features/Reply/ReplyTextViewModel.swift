import SwiftUI

@Observable
@MainActor
final class ReplyTextViewModel {
    let targetMessage: BoundMessage

    var messageText = ""
    var selectedAura: AuraGradient = .bluePurple
    var isAutoMode = true
    var isSending = false
    var error: Error?

    var canSend: Bool {
        !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !isSending
    }

    var recipientTag: String {
        targetMessage.sender?.boundTag ?? "unknown"
    }

    init(targetMessage: BoundMessage) {
        self.targetMessage = targetMessage
    }

    func send() async {
        guard canSend else { return }
        isSending = true
        defer { isSending = false }

        let aura = isAutoMode ? AuraGradient.auto : selectedAura

        // TODO: Replace with MessageService.send() when Supabase is connected
        do {
            try await Task.sleep(for: .milliseconds(500))
            print("Reply sent to @\(recipientTag): \"\(messageText)\" with aura \(aura.startHex)->\(aura.endHex)")
        } catch {
            self.error = error
        }
    }
}
