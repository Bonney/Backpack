import SwiftUI

public struct AquaButtonStyle: ButtonStyle {
    @Environment(\.controlSize) private var controlSize: ControlSize
    private let main = Gradient(colors: [Color(white: 1, opacity: 0.9), Color(white: 1, opacity: 0)])
    private let highlight = Gradient(colors: [Color.white, Color(white: 1, opacity: 0.5), Color(white: 1, opacity: 0.1)])

    public init() {
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        makeLabel(configuration: configuration)
            .padding(.vertical, controlSize.minimumButtonHeight * 0.25)
            .padding(.horizontal, controlSize.minimumButtonHeight * 0.5)
            .frame(idealHeight: controlSize.minimumButtonHeight)
            .background(makeBackground(configuration: configuration))
            // Animations
            .scaleEffect(configuration.isPressed ? 0.96 : 1.00)
            .opacity(configuration.isPressed ? 0.6 : 1.00)
            .animation(.interpolatingSpring(.bouncy), value: configuration.isPressed)
    }

    func makeLabel(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: controlSize.minimumButtonHeight * 0.4))
            .bold()
            .foregroundStyle(.ultraThickMaterial.shadow(.drop(radius: 2)))
    }

    func makeBackground(configuration: Self.Configuration) -> some View {
        ZStack {
            // Primary Color
            ContainerRelativeShape().foregroundStyle(.tint.opacity(0.95))

            // Gradient over Primary Color
//            ContainerRelativeShape().foregroundStyle(.linearGradient(main, startPoint: .top, endPoint: .bottom).opacity(0.5))
        }
        .overlay(alignment: .top) {
            // Top Highlight
            ContainerRelativeShape()
                .foregroundStyle(.linearGradient(highlight, startPoint: .top, endPoint: .bottom))
                .frame(maxHeight: controlSize.minimumButtonHeight * 0.35)
                .padding(.horizontal, controlSize.minimumButtonHeight * 0.15)
        }
        .overlay(alignment: .bottom) {
            // Bottom Highlight
            ContainerRelativeShape()
                .foregroundStyle(.linearGradient(highlight, startPoint: .bottom, endPoint: .top))
                .blur(radius: 6.0, opaque: false)
                .frame(maxHeight: controlSize.minimumButtonHeight * 0.2)
        }
        .overlay {
            // Button Outline
            ContainerRelativeShape()
                .stroke(.tint.tertiary, lineWidth: 1.0)
        }
    }
}

public extension ButtonStyle where Self == AquaButtonStyle {
    static var aqua: AquaButtonStyle { AquaButtonStyle() }
}

#Preview {
    VStack {
//        Button("Set up your iPhone") { }
//            .tint(.green)
//            .controlSize(.regular)

        Button { } label: {
            Text("Log a Drink").frame(maxWidth: .infinity, alignment: .center)
        }
        .tint(.blue)
        .controlSize(.large)
        .containerShape(.rect(cornerRadius: 22))

//        HStack {
//            Button("Cancel", action: {}).tint(Color(white: 0.9))
//            Button("Save", action: {}).tint(.blue)
//        }
//        .controlSize(.small)

    }
    .buttonStyle(.aqua)
    .padding()
    .containerShape(.capsule)
}

