import SwiftUI

enum BoundFont {
    static let largeTitle = Font.system(size: 28, weight: .bold, design: .rounded)
    static let title = Font.system(size: 22, weight: .bold, design: .rounded)
    static let cardMessage = Font.system(size: 20, weight: .semibold, design: .rounded)
    static let senderName = Font.system(size: 16, weight: .medium)
    static let headline = Font.system(size: 17, weight: .semibold)
    static let body = Font.system(size: 16, weight: .regular)
    static let callout = Font.system(size: 15, weight: .medium)
    static let button = Font.system(size: 15, weight: .semibold)
    static let caption = Font.system(size: 13, weight: .medium)
    static let tag = Font.system(size: 14, weight: .semibold, design: .monospaced)
    static let small = Font.system(size: 12, weight: .regular)
}
