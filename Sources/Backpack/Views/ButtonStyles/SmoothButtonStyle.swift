import SwiftUI

public struct SmoothButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.controlSize) private var controlSize

    public init() {
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.white)
            .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 0)
            .font(controlSize.font)
            .padding(.horizontal, controlSize.horizontalLabelPadding)
            .frame(minHeight: controlSize.minimumButtonHeight)
            .background(backgroundStyle)
    }

    @ViewBuilder var backgroundStyle: some View {
        let shape = AnyShape(controlSize.controlShape)

        ZStack {
            shape.foregroundStyle(.tint)
            shape.foregroundStyle(
                LinearGradient(colors: [Color.white, Color.clear, Color.black], startPoint: .top, endPoint: .bottom)
            )
            .blendMode(.softLight)
            .opacity(colorScheme == .light ? 0.8 : 1.0)
        }
    }
}

public extension ButtonStyle where Self == SmoothButtonStyle {
    static var smooth: Self {
        SmoothButtonStyle()
    }
}

#Preview {
    ScrollView {
        HStack {
            Button(role: .cancel, action: { }) {
                Text("Cancel")
            }
            .buttonStyle(.bordered)
            .tint(.red)

            Button("Save Drink", systemImage: "checkmark", action: { })
                .buttonStyle(.smooth)
                .tint(.teal)
        }
        ForEach([ControlSize.mini, .small, .regular, .large, .extraLarge], id: \.self) { controlSize in
            GroupBox(String(describing: controlSize)) {
                VStack {
                    HStack {
                        Button("Bordered", action: {})
                            .buttonStyle(.bordered)
                            .tint(nil)

                        Button("Bordered Tint", action: {})
                            .buttonStyle(.bordered)
                            .tint(.purple)
                    }

                    Divider()

                    HStack {
                        Button("Prominent", action: {})
                            .buttonStyle(.borderedProminent)
                            .tint(nil)

                        Button("Prominent Tint", action: {})
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                    }

                    Divider()

                    HStack {
                        Button("Smooth", action: {})
                            .buttonStyle(.smooth)
                            .tint(nil)

                        Button("Smooth Tint", action: {})
                            .buttonStyle(.smooth)
                            .tint(.green)
                    }
                }
            }
            .controlSize(controlSize)
        }
    }
    .contentMargins(8, for: .scrollContent)
}
