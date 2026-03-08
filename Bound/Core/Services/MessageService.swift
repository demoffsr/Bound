import Foundation
import Supabase

enum MessageService {

    static func fetchMessages(for userId: UUID) async throws -> [BoundMessage] {
        try await supabase
            .from(Tables.messages)
            .select("*, sender:profiles!sender_id(id, bound_tag, display_name, avatar_url)")
            .eq("recipient_id", value: userId.uuidString)
            .order("created_at", ascending: false)
            .limit(50)
            .execute()
            .value
    }

    static func send(
        body: String,
        auraStart: String,
        auraEnd: String,
        from senderId: UUID,
        to recipientId: UUID
    ) async throws {
        let message = NewMessage(
            senderId: senderId,
            recipientId: recipientId,
            body: body,
            auraColorStart: auraStart,
            auraColorEnd: auraEnd
        )
        try await supabase
            .from(Tables.messages)
            .insert(message)
            .execute()
    }

    static func markAsRead(id: UUID) async throws {
        try await supabase
            .from(Tables.messages)
            .update(["is_read": true])
            .eq("id", value: id.uuidString)
            .execute()
    }
}
