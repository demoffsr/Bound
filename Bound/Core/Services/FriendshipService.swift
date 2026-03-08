import Foundation
import Supabase

enum FriendshipService {

    static func sendRequest(from requesterId: UUID, to addresseeId: UUID) async throws {
        let data: [String: String] = [
            "requester_id": requesterId.uuidString,
            "addressee_id": addresseeId.uuidString,
        ]
        try await supabase.from(Tables.friendships).insert(data).execute()
    }

    static func acceptRequest(id: UUID) async throws {
        try await supabase
            .from(Tables.friendships)
            .update(["status": FriendshipStatus.accepted.rawValue, "updated_at": ISO8601DateFormatter().string(from: .now)])
            .eq("id", value: id.uuidString)
            .execute()
    }

    static func rejectRequest(id: UUID) async throws {
        try await supabase
            .from(Tables.friendships)
            .update(["status": FriendshipStatus.rejected.rawValue, "updated_at": ISO8601DateFormatter().string(from: .now)])
            .eq("id", value: id.uuidString)
            .execute()
    }

    static func listFriends(for userId: UUID) async throws -> [BoundFriendship] {
        let asRequester: [BoundFriendship] = try await supabase
            .from(Tables.friendships)
            .select("*, addressee:profiles!addressee_id(id, bound_tag, display_name, avatar_url)")
            .eq("requester_id", value: userId.uuidString)
            .eq("status", value: FriendshipStatus.accepted.rawValue)
            .execute()
            .value

        let asAddressee: [BoundFriendship] = try await supabase
            .from(Tables.friendships)
            .select("*, requester:profiles!requester_id(id, bound_tag, display_name, avatar_url)")
            .eq("addressee_id", value: userId.uuidString)
            .eq("status", value: FriendshipStatus.accepted.rawValue)
            .execute()
            .value

        return asRequester + asAddressee
    }

    static func listPendingRequests(for userId: UUID) async throws -> [BoundFriendship] {
        try await supabase
            .from(Tables.friendships)
            .select("*, requester:profiles!requester_id(id, bound_tag, display_name, avatar_url)")
            .eq("addressee_id", value: userId.uuidString)
            .eq("status", value: FriendshipStatus.pending.rawValue)
            .execute()
            .value
    }
}
