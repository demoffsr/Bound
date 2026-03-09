import SwiftUI

struct AvatarView: View {
    let url: String?
    let size: CGFloat
    var borderColor: Color? = nil
    var borderWidth: CGFloat = 2

    var body: some View {
        Group {
            if let url, let imageUrl = URL(string: url) {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFill()
                    case .failure:
                        placeholderCircle
                    case .empty:
                        placeholderCircle
                            .overlay { ProgressView().tint(.white) }
                    @unknown default:
                        placeholderCircle
                    }
                }
            } else {
                placeholderCircle
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay {
            if let borderColor {
                Circle().stroke(borderColor, lineWidth: borderWidth)
            }
        }
    }

    private var placeholderCircle: some View {
        Circle()
            .fill(Color.white.opacity(0.12))
            .glassEffect(.regular, in: .circle)
            .overlay {
                Image(systemName: "person.fill")
                    .font(.system(size: size * 0.4))
                    .foregroundStyle(.white)
            }
    }
}

struct AvatarStackView: View {
    let urls: [String?]
    let size: CGFloat
    let maxVisible: Int
    let borderColor: Color
    let borderWidth: CGFloat
    let showShadow: Bool
    let showGlass: Bool
    let overlapFraction: CGFloat

    init(
        urls: [String?],
        size: CGFloat = 28,
        maxVisible: Int = 3,
        borderColor: Color = BoundColors.cardBackground,
        borderWidth: CGFloat = 2,
        showShadow: Bool = false,
        showGlass: Bool = false,
        overlapFraction: CGFloat = 0.3
    ) {
        self.urls = urls
        self.size = size
        self.maxVisible = maxVisible
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.showShadow = showShadow
        self.showGlass = showGlass
        self.overlapFraction = overlapFraction
    }

    private var visibleUrls: [String?] {
        Array(urls.prefix(maxVisible))
    }

    var body: some View {
        HStack(spacing: -(size * overlapFraction)) {
            ForEach(Array(visibleUrls.enumerated()), id: \.offset) { index, url in
                let isLast = index == visibleUrls.count - 1
                AvatarView(url: url, size: size, borderColor: borderColor, borderWidth: borderWidth)
                    .overlay {
                        if showGlass {
                            Circle().fill(.ultraThinMaterial.opacity(0.5))
                        }
                    }
                    .shadow(color: showShadow && !isLast ? .black.opacity(0.7) : .clear, radius: 2, x: 2, y: 0)
                    .zIndex(Double(maxVisible - index))
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        AvatarView(url: nil, size: 60)
        AvatarStackView(urls: [nil, nil, nil])
    }
    .padding()
    .background(BoundColors.background)
}
