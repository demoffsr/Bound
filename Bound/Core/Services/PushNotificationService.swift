import UIKit

enum PushNotificationService {

    static func requestPermission() async -> Bool {
        do {
            let granted = try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .badge, .sound])
            if granted {
                await MainActor.run {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
            return granted
        } catch {
            print("Push notification permission error: \(error)")
            return false
        }
    }

    static func registerToken(_ tokenData: Data) async {
        let token = tokenData.map { String(format: "%02.2hhx", $0) }.joined()
        do {
            let userId = try await AuthService.currentUserId()
            try await UserService.updateDeviceToken(token, for: userId)
        } catch {
            print("Failed to register device token: \(error)")
        }
    }
}
