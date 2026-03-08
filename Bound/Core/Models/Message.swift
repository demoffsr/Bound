import Foundation

struct BoundMessage: Codable, Identifiable, Sendable, Hashable {
    let id: UUID
    let senderId: UUID
    let recipientId: UUID
    let body: String
    let auraColorStart: String
    let auraColorEnd: String
    var isRead: Bool
    let createdAt: Date

    /// Joined sender profile (populated via Supabase select with join)
    var sender: BoundUser?

    var aura: AuraGradient {
        AuraGradient(startHex: auraColorStart, endHex: auraColorEnd)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case senderId = "sender_id"
        case recipientId = "recipient_id"
        case body
        case auraColorStart = "aura_color_start"
        case auraColorEnd = "aura_color_end"
        case isRead = "is_read"
        case createdAt = "created_at"
        case sender
    }
}

struct NewMessage: Codable, Sendable {
    let senderId: UUID
    let recipientId: UUID
    let body: String
    let auraColorStart: String
    let auraColorEnd: String

    enum CodingKeys: String, CodingKey {
        case senderId = "sender_id"
        case recipientId = "recipient_id"
        case body
        case auraColorStart = "aura_color_start"
        case auraColorEnd = "aura_color_end"
    }
}
