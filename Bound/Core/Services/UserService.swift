import Foundation
import Supabase

enum UserService {

    static func getProfile(id: UUID) async throws -> BoundUser {
        try await supabase
            .from(Tables.profiles)
            .select()
            .eq("id", value: id.uuidString)
            .single()
            .execute()
            .value
    }

    static func updateProfile(
        id: UUID,
        boundTag: String? = nil,
        displayName: String? = nil,
        avatarUrl: String? = nil,
        isSearchable: Bool? = nil
    ) async throws {
        var updates: [String: AnyEncodable] = [
            "updated_at": AnyEncodable(ISO8601DateFormatter().string(from: .now))
        ]
        if let boundTag { updates["bound_tag"] = AnyEncodable(boundTag) }
        if let displayName { updates["display_name"] = AnyEncodable(displayName) }
        if let avatarUrl { updates["avatar_url"] = AnyEncodable(avatarUrl) }
        if let isSearchable { updates["is_searchable"] = AnyEncodable(isSearchable) }

        try await supabase
            .from(Tables.profiles)
            .update(updates)
            .eq("id", value: id.uuidString)
            .execute()
    }

    static func searchByTag(query: String) async throws -> [BoundUser] {
        try await supabase
            .from(Tables.profiles)
            .select()
            .ilike("bound_tag", pattern: "%\(query)%")
            .eq("is_searchable", value: true)
            .limit(20)
            .execute()
            .value
    }

    static func updateDeviceToken(_ token: String, for userId: UUID) async throws {
        try await supabase
            .from(Tables.profiles)
            .update(["device_token": token])
            .eq("id", value: userId.uuidString)
            .execute()
    }
}

struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void

    init<T: Encodable>(_ value: T) {
        _encode = { encoder in try value.encode(to: encoder) }
    }

    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
