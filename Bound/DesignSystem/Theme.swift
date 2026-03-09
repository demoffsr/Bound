import SwiftUI

enum BoundColors {
    // MARK: - Backgrounds
    static let background = Color(red: 0.086, green: 0.086, blue: 0.086)
    static let cardBackground = Color(red: 0.10, green: 0.10, blue: 0.18)
    static let surfaceGlass = Color.white.opacity(0.08)

    // MARK: - Text
    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.6)
    static let textMuted = Color.white.opacity(0.4)

    // MARK: - Accent
    static let accent = Color(red: 0.55, green: 0.36, blue: 0.96)
}

enum BoundSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
    static let xxxl: CGFloat = 32
}

enum BoundRadius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let card: CGFloat = 28
    static let full: CGFloat = 100
}
