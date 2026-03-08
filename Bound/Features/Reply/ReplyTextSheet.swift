import SwiftUI

struct ReplyTextSheet: View {
    @State private var viewModel: ReplyTextViewModel
    let onSent: () -> Void

    @FocusState private var isTextFieldFocused: Bool

    init(targetMessage: BoundMessage, onSent: @escaping () -> Void) {
        _viewModel = State(initialValue: ReplyTextViewModel(targetMessage: targetMessage))
        self.onSent = onSent
    }

    var body: some View {
        VStack(spacing: BoundSpacing.xl) {
            Text("Replay to @\(viewModel.recipientTag)")
                .font(BoundFont.headline)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, BoundSpacing.lg)

            TextField("Write Message...", text: $viewModel.messageText, axis: .vertical)
                .font(BoundFont.body)
                .foregroundStyle(.white)
                .tint(.white)
                .lineLimit(3...6)
                .padding(BoundSpacing.lg)
                .background(Color.white.opacity(0.1), in: RoundedRectangle(cornerRadius: BoundRadius.md))
                .focused($isTextFieldFocused)

            AuraColorPicker(
                selectedAura: $viewModel.selectedAura,
                isAutoMode: $viewModel.isAutoMode
            )

            Spacer()

            Button {
                Task {
                    await viewModel.send()
                    onSent()
                }
            } label: {
                Text(viewModel.isSending ? "Sending..." : "Send")
                    .font(BoundFont.button)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, BoundSpacing.lg)
                    .background(
                        viewModel.canSend
                            ? Color.white.opacity(0.2)
                            : Color.white.opacity(0.08),
                        in: RoundedRectangle(cornerRadius: BoundRadius.md)
                    )
            }
            .disabled(!viewModel.canSend)
        }
        .padding(.horizontal, BoundSpacing.xl)
        .padding(.bottom, BoundSpacing.lg)
        .onAppear { isTextFieldFocused = true }
    }
}

#Preview {
    Color.black
        .sheet(isPresented: .constant(true)) {
            ReplyTextSheet(targetMessage: PreviewData.sampleMessages[0], onSent: {})
                .presentationDetents([.medium])
                .presentationBackground(.ultraThinMaterial)
        }
}
