import SwiftUI

struct AuraGradient: Codable, Sendable, Hashable {
    let startHex: String
    let endHex: String

    var startColor: Color { Color(hex: startHex) }
    var endColor: Color { Color(hex: endHex) }

    var gradient: LinearGradient {
        LinearGradient(
            colors: [startColor, endColor],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // MARK: - Presets

    static let bluePurple = AuraGradient(startHex: "#3D47F0", endHex: "#8C5CF5")
    static let pinkRose = AuraGradient(startHex: "#ED4A99", endHex: "#F5405E")
    static let greenCyan = AuraGradient(startHex: "#10BA82", endHex: "#06B5D4")
    static let orangeRed = AuraGradient(startHex: "#F59E0A", endHex: "#F04545")
    static let tealIndigo = AuraGradient(startHex: "#14B8A6", endHex: "#6366F1")
    static let purplePink = AuraGradient(startHex: "#9433EB", endHex: "#ED4A99")
    static let cyanBlue = AuraGradient(startHex: "#06B5D4", endHex: "#3D47F0")

    static let allPresets: [AuraGradient] = [
        .bluePurple, .pinkRose, .greenCyan, .orangeRed,
        .tealIndigo, .purplePink, .cyanBlue,
    ]

    /// Random preset for AUTO mode
    static var auto: AuraGradient {
        allPresets.randomElement() ?? .bluePurple
    }
}

// MARK: - Color hex init

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
