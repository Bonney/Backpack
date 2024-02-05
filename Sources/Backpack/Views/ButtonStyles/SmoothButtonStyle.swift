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
            .scaleEffect(configuration.isPressed ? 0.95 : 1.00)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.interactiveSpring, value: configuration.isPressed)
    }

    @ViewBuilder var backgroundStyle: some View {
        let shape = AnyShape(controlSize.controlShape)

        shape.foregroundStyle(.tint)
            .overlay {
                shape.foregroundStyle(
                    LinearGradient(stops: [
                        .init(color: Color.white.opacity(0.4), location: 0.0),
                        .init(color: Color.white.opacity(0.0), location: 0.5),
                        .init(color: Color.black.opacity(0.0), location: 0.5),
                        .init(color: Color.black.opacity(0.4), location: 1.0),
                    ], startPoint: .top, endPoint: .bottom)

                )
                .blendMode(.softLight)
            }
    }
}

public extension ButtonStyle where Self == SmoothButtonStyle {
    static var smooth: Self {
        SmoothButtonStyle()
    }
}

#Preview {
    List {
        ForEach([ControlSize.mini, .small, .regular, .large, .extraLarge], id: \.self) { controlSize in
            Section(String(describing: controlSize)) {
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
}
