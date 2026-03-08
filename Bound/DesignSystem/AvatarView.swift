import SwiftUI

struct AvatarView: View {
    let url: String?
    let size: CGFloat
    var borderColor: Color? = nil

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
                Circle().stroke(borderColor, lineWidth: 2)
            }
        }
    }

    private var placeholderCircle: some View {
        Circle()
            .fill(BoundColors.cardBackground)
            .overlay {
                Image(systemName: "person.fill")
                    .font(.system(size: size * 0.4))
                    .foregroundStyle(BoundColors.textMuted)
            }
    }
}

struct AvatarStackView: View {
    let urls: [String?]
    let size: CGFloat
    let maxVisible: Int

    init(urls: [String?], size: CGFloat = 28, maxVisible: Int = 3) {
        self.urls = urls
        self.size = size
        self.maxVisible = maxVisible
    }

    var body: some View {
        HStack(spacing: -(size * 0.3)) {
            ForEach(Array(urls.prefix(maxVisible).enumerated()), id: \.offset) { index, url in
                AvatarView(url: url, size: size, borderColor: BoundColors.cardBackground)
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
