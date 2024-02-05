import SwiftUI

public struct SmoothButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.controlSize) private var controlSize
    @Environment(\.tintColor) private var tintColor

    private var maxWidth: CGFloat? = nil

    public init(maxWidth: CGFloat? = nil) {
        self.maxWidth = maxWidth
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 0)
            .font(controlSize.font)
            .frame(maxWidth: maxWidth, alignment: .center)
            .padding(.horizontal, controlSize.horizontalLabelPadding)
            .frame(minHeight: controlSize.minimumButtonHeight)
            .background(backgroundStyle)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.00)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.interactiveSpring, value: configuration.isPressed)
    }

    @ViewBuilder var backgroundStyle: some View {
        let shape = AnyShape(controlSize.controlShape)
        let highlight = LinearGradient(
            colors: [Color.white.opacity(0.4), Color.clear],
            startPoint: .top, endPoint: .bottom
        )

        let lowlight = LinearGradient(
            colors: [Color.clear, Color.white.opacity(0.2)],
            startPoint: .center, endPoint: .bottom
        )

        shape
            .fill(
                tintColor.gradient
                    .shadow(.inner(color: Color.white.opacity(0.5), radius: 1.5, y: 1))
                    .shadow(.inner(color: Color.white.opacity(0.2), radius: 3.0, y: 0))
            )
//            .stroke(highlight, lineWidth: 1.0)
//            .stroke(lowlight, lineWidth: 1.0)
//
//        shape.foregroundStyle(.tint)
//            .overlay {
//                shape.foregroundStyle(
//                    LinearGradient(stops: [
//                        .init(color: Color.white.opacity(0.4), location: 0.0),
//                        .init(color: Color.white.opacity(0.0), location: 0.5),
//                        .init(color: Color.black.opacity(0.0), location: 0.5),
//                        .init(color: Color.black.opacity(0.4), location: 1.0),
//                    ], startPoint: .top, endPoint: .bottom)
//
//                )
//                .blendMode(.softLight)
//            }
    }
}

public extension ButtonStyle where Self == SmoothButtonStyle {
    static var smooth: Self {
        SmoothButtonStyle(maxWidth: nil)
    }

    static func smooth(maxWidth: CGFloat? = nil) -> Self {
        SmoothButtonStyle(maxWidth: maxWidth)
    }
}

struct SmoothButtonStyleDemo: View {
    @State var colorHue: Double = 0.0

    var body: some View {
        VStack {
            ForEach([ControlSize.mini, .small, .regular, .large, .extraLarge], id: \.self) { controlSize in
                Button("Smooth Button – \(String(describing: controlSize))", action: { })
                    .buttonStyle(.smooth)
                    .controlSize(controlSize)
            }

            Divider()

            Slider(value: $colorHue, in: 0...360)
        }
        .padding()
        .tintColor(Color(hueOutOf360: colorHue))
    }
}

#Preview {
    SmoothButtonStyleDemo()
}
