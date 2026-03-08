import Foundation

struct BoundUser: Codable, Identifiable, Sendable, Hashable {
    let id: UUID
    var boundTag: String
    var displayName: String
    var avatarUrl: String?
    var isSearchable: Bool
    var deviceToken: String?
    let createdAt: Date
    var updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case boundTag = "bound_tag"
        case displayName = "display_name"
        case avatarUrl = "avatar_url"
        case isSearchable = "is_searchable"
        case deviceToken = "device_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
