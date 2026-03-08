import Foundation

enum PreviewData {

    // MARK: - Users

    static let currentUser = BoundUser(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
        boundTag: "BoundTag",
        displayName: "Dmitrii Demidov",
        avatarUrl: nil,
        isSearchable: true,
        deviceToken: nil,
        createdAt: .now,
        updatedAt: .now
    )

    static let alex = BoundUser(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
        boundTag: "demoff_sr",
        displayName: "Alex Garfield",
        avatarUrl: nil,
        isSearchable: true,
        deviceToken: nil,
        createdAt: .now,
        updatedAt: .now
    )

    static let maria = BoundUser(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
        boundTag: "maria_k",
        displayName: "Maria Kim",
        avatarUrl: nil,
        isSearchable: true,
        deviceToken: nil,
        createdAt: .now,
        updatedAt: .now
    )

    static let james = BoundUser(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
        boundTag: "james_w",
        displayName: "James Wilson",
        avatarUrl: nil,
        isSearchable: true,
        deviceToken: nil,
        createdAt: .now,
        updatedAt: .now
    )

    // MARK: - Messages

    static let sampleMessages: [BoundMessage] = [
        BoundMessage(
            id: UUID(),
            senderId: alex.id,
            recipientId: currentUser.id,
            body: "Looking forward to our next adventure together!",
            auraColorStart: "#3D47F0",
            auraColorEnd: "#8C5CF5",
            isRead: false,
            createdAt: Calendar.current.date(bySettingHour: 15, minute: 30, second: 0, of: .now)!,
            sender: alex
        ),
        BoundMessage(
            id: UUID(),
            senderId: maria.id,
            recipientId: currentUser.id,
            body: "You make the world a better place just by being in it!",
            auraColorStart: "#ED4A99",
            auraColorEnd: "#F5405E",
            isRead: false,
            createdAt: Calendar.current.date(bySettingHour: 14, minute: 15, second: 0, of: .now)!,
            sender: maria
        ),
        BoundMessage(
            id: UUID(),
            senderId: james.id,
            recipientId: currentUser.id,
            body: "Thanks for always being there for me, buddy!",
            auraColorStart: "#10BA82",
            auraColorEnd: "#06B5D4",
            isRead: true,
            createdAt: Calendar.current.date(bySettingHour: 11, minute: 0, second: 0, of: .now)!,
            sender: james
        ),
    ]

    static let emptyMessages: [BoundMessage] = []

    static let sampleFriends: [BoundUser] = [alex, maria, james]
}
