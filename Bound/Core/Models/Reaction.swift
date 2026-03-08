import Foundation

enum ReactionType: String, Codable, Sendable, CaseIterable {
    case heart
    case thumbsUp = "thumbs_up"
    case concerned
    case angry

    var emoji: String {
        switch self {
        case .heart: return "\u{2764}\u{FE0F}"
        case .thumbsUp: return "\u{1F44D}"
        case .concerned: return "\u{1F625}"
        case .angry: return "\u{1F624}"
        }
    }
}

struct BoundReaction: Codable, Identifiable, Sendable, Hashable {
    let id: UUID
    let messageId: UUID
    let userId: UUID
    let reaction: ReactionType
    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case messageId = "message_id"
        case userId = "user_id"
        case reaction
        case createdAt = "created_at"
    }
}

struct NewReaction: Codable, Sendable {
    let messageId: UUID
    let userId: UUID
    let reaction: ReactionType

    enum CodingKeys: String, CodingKey {
        case messageId = "message_id"
        case userId = "user_id"
        case reaction
    }
}
