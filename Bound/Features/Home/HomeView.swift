import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: BoundSpacing.lg) {
                    topBar

                    if viewModel.messages.isEmpty && !viewModel.isLoading {
                        EmptyStateView()
                    } else {
                        if viewModel.unreadCount > 0 {
                            CheckRecentCard(
                                messageCount: viewModel.unreadCount,
                                friendAvatarUrls: viewModel.recentFriendAvatars
                            )
                        }

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
                .padding(.bottom, 80)
            }
            .scrollIndicators(.hidden)
            .refreshable {
                await viewModel.loadMessages()
            }

            BoundTabBar()
        }
        .background(BoundColors.background)
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

    private var topBar: some View {
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
            .glassEffect(.regular, in: .capsule)
        }
        .padding(.top, BoundSpacing.sm)
    }
}

#Preview {
    HomeView()
}
