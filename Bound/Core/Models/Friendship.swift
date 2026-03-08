import Foundation

enum FriendshipStatus: String, Codable, Sendable {
    case pending
    case accepted
    case rejected
    case blocked
}

struct BoundFriendship: Codable, Identifiable, Sendable, Hashable {
    let id: UUID
    let requesterId: UUID
    let addresseeId: UUID
    var status: FriendshipStatus
    let createdAt: Date
    var updatedAt: Date

    var requester: BoundUser?
    var addressee: BoundUser?

    enum CodingKeys: String, CodingKey {
        case id
        case requesterId = "requester_id"
        case addresseeId = "addressee_id"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case requester
        case addressee
    }
}
