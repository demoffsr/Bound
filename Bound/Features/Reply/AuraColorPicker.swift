import SwiftUI

struct AuraColorPicker: View {
    @Binding var selectedAura: AuraGradient
    @Binding var isAutoMode: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: BoundSpacing.md) {
            Text("Replay Aura")
                .font(BoundFont.headline)
                .foregroundStyle(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: BoundSpacing.md) {
                    autoButton

                    ForEach(Array(AuraGradient.allPresets.enumerated()), id: \.offset) { _, aura in
                        auraCircle(aura: aura)
                    }
                }
            }

            Text("Our AI model will generate color aura according to your message vibe.")
                .font(BoundFont.small)
                .foregroundStyle(BoundColors.textMuted)
        }
    }

    private var autoButton: some View {
        Button {
            isAutoMode = true
            BoundHaptics.selection()
        } label: {
            Text("AUTO")
                .font(.system(size: 11, weight: .bold, design: .monospaced))
                .foregroundStyle(isAutoMode ? .black : .white)
                .frame(width: 44, height: 44)
                .background(
                    isAutoMode
                        ? AnyShapeStyle(Color.white)
                        : AnyShapeStyle(Color.white.opacity(0.2)),
                    in: Circle()
                )
                .overlay {
                    if isAutoMode {
                        Circle().stroke(Color.white, lineWidth: 2).padding(-3)
                    }
                }
        }
    }

    private func auraCircle(aura: AuraGradient) -> some View {
        Button {
            selectedAura = aura
            isAutoMode = false
            BoundHaptics.selection()
        } label: {
            Circle()
                .fill(aura.gradient)
                .frame(width: 44, height: 44)
                .overlay {
                    if !isAutoMode && selectedAura == aura {
                        Circle().stroke(Color.white, lineWidth: 2).padding(-3)
                    }
                }
        }
    }
}

#Preview {
    struct Wrapper: View {
        @State var aura = AuraGradient.bluePurple
        @State var isAuto = true
        var body: some View {
            AuraColorPicker(selectedAura: $aura, isAutoMode: $isAuto)
                .padding()
                .background(BoundColors.background)
        }
    }
    return Wrapper()
}
