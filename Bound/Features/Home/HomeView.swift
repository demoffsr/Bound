import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                header
                    .padding(.horizontal, BoundSpacing.lg)

                ScrollView {
                    VStack(spacing: BoundSpacing.lg) {
                        if viewModel.messages.isEmpty && !viewModel.isLoading {
                            EmptyStateView()
                        } else {
                            ForEach(viewModel.messages) { message in
                                MessageCardView(
                                    message: message,
                                    onWriteBack: {
                                        viewModel.startReply(to: message)
                                    },
                                    onReaction: { type in
                                        Task { await viewModel.sendReaction(type, for: message) }
                                    }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, BoundSpacing.lg)
                    .padding(.top, 12)
                    .padding(.bottom, 80)
                }
                .scrollIndicators(.hidden)
                .refreshable {
                    await viewModel.loadMessages()
                }
            }

            BoundTabBar()
        }
        .background {
            ZStack(alignment: .top) {
                BoundColors.background

                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .white.opacity(0.035), location: 0.0),
                        Gradient.Stop(color: .white.opacity(0), location: 1.0),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
                .frame(height: 280)
                .ignoresSafeArea()
            }
            .ignoresSafeArea()
        }
        .task {
            await viewModel.loadMessages()
        }
        .sheet(item: $viewModel.replyTarget) { message in
            ReplyTextSheet(targetMessage: message) {
                viewModel.replyTarget = nil
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
            .presentationBackground(.ultraThinMaterial)
        }
    }

    private var header: some View {
        VStack(spacing: 24) {
            // Profile bar
            HStack(spacing: BoundSpacing.md) {
                AvatarView(url: viewModel.currentUser.avatarUrl, size: 40)
                    .padding(2)
                    .glassEffect(.regular, in: .circle)

                VStack(alignment: .leading, spacing: 2) {
                    Text("@\(viewModel.currentUser.boundTag)")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.white)
                    Text(viewModel.currentUser.displayName)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(BoundColors.textSecondary)
                }

                Spacer()

                HStack(spacing: 0) {
                    Button(action: {}) {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.white)
                            .frame(width: 48, height: 44)
                    }
                    .buttonStyle(.plain)

                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.white)
                            .frame(width: 48, height: 44)
                    }
                    .buttonStyle(.plain)
                }
                .background(Color.white.opacity(0.12))
                .clipShape(Capsule())
                .glassEffect(.regular, in: .capsule)
            }

            // Recent messages card
            if viewModel.unreadCount > 0 {
                CheckRecentCard(
                    messageCount: viewModel.unreadCount,
                    friendAvatarUrls: viewModel.recentFriendAvatars
                )
            }
        }
        .padding(.bottom, 14)
        .frame(maxWidth: .infinity, alignment: .top)
    }
}

#Preview {
    HomeView()
}
