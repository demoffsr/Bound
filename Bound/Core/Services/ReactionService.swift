import Foundation
import Supabase

enum ReactionService {

    static func sendReaction(type: ReactionType, messageId: UUID, userId: UUID) async throws {
        let reaction = NewReaction(messageId: messageId, userId: userId, reaction: type)
        try await supabase
            .from(Tables.reactions)
            .upsert(reaction, onConflict: "message_id,user_id")
            .execute()
    }

    static func fetchReactions(for messageId: UUID) async throws -> [BoundReaction] {
        try await supabase
            .from(Tables.reactions)
            .select()
            .eq("message_id", value: messageId.uuidString)
            .execute()
            .value
    }
}
