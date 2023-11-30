import SwiftUI

public struct AquaButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @Environment(\.controlSize) private var controlSize: ControlSize
    @Environment(\.backgroundStyle) private var backgroundStyle: AnyShapeStyle?
    @Environment(\.font) private var setFont: Font?

    private var backgroundProminence: BackgroundProminence

    public init(_ backgroundProminence: BackgroundProminence) {
        self.backgroundProminence = backgroundProminence
    }

    public func makeBody(configuration: Self.Configuration) -> some View {
        makeLabel(configuration: configuration)
            .frame(minHeight: controlSize.minimumButtonHeight)
            .padding(.horizontal, controlSize.horizontalLabelPadding)
            .background(makeBackground(configuration: configuration))
            .grayscale(configuration.isPressed ? 0.2 : 0.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0, anchor: .center)
            .animation(.interpolatingSpring(.smooth), value: configuration.isPressed)
            .sensoryFeedback(.levelChange, trigger: configuration.isPressed)
    }

    // MARK: Foreground

    var foregroundFillStyle: AnyShapeStyle {
        switch backgroundProminence {
            case .increased:    AnyShapeStyle(Color.white.opacity(0.9).shadow(.drop(radius: 2)))
            case .standard:     AnyShapeStyle(TintShapeStyle.tint.shadow(.drop(radius: 0.1)))
            default:            AnyShapeStyle(Color.yellow)

        }
    }

    func makeLabel(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(setFont ?? controlSize.font)
            .foregroundStyle(foregroundFillStyle)
            .shadow(color: Color.black.opacity(0.15), radius: 2, x: 0, y: 0.5)
    }

    // MARK: Background

    var backgroundFillStyle: AnyShapeStyle {
        switch backgroundProminence {
            case .increased:    AnyShapeStyle(TintShapeStyle.tint.opacity(0.95))
            case .standard:     AnyShapeStyle(Material.ultraThin)
            default:            AnyShapeStyle(Color.pink)

        }
    }

    var borderFillStyle: AnyShapeStyle {
        switch backgroundProminence {
            case .increased:    AnyShapeStyle(TintShapeStyle.tint.opacity(0.2))
            case .standard:     AnyShapeStyle(FillShapeStyle.fill.secondary)
            default:            AnyShapeStyle(Color.green)

        }
    }

    var highlightGradient: [Color] {
        switch colorScheme {
            case .light:        [Color.white.opacity(0.70), Color.white.opacity(0.30), Color.white.opacity(0.10)]
            case .dark:         [Color.white.opacity(0.30), Color.white.opacity(0.10), Color.white.opacity(0.05)]
            @unknown default:   [Color.red, Color.blue]
        }
    }

    func makeBackground(configuration: Self.Configuration) -> some View {
        Squircle()
            .foregroundStyle(backgroundFillStyle)
            .overlay(alignment: .top) {
                Squircle()
                    .foregroundStyle(
                        .linearGradient(colors: highlightGradient, startPoint: .top, endPoint: .bottom)
                    )
                    .blur(radius: 2.0)
                    .scaleEffect(x: 0.96, y: 0.35, anchor: .top)
            }
            .clipShape(Squircle())
            .overlay {
                Squircle().stroke(borderFillStyle, lineWidth: 1.0)
            }
            .shadow(color: .gray.opacity(0.1), radius: 8, x: 0, y: 4)
    }
}

public extension ButtonStyle where Self == AquaButtonStyle {
    static var aqua: AquaButtonStyle {
        AquaButtonStyle(.standard)
    }

    static var aquaProminent: AquaButtonStyle {
        AquaButtonStyle(.increased)
    }
}

#Preview {
    VStack {
        Button { } label: {
            Text("No Tint").frame(width: 160)
        }
        .buttonStyle(.aqua)
        .tint(nil)

        HStack {
            Button("Cancel", action: { })
                .tint(.red)
                .buttonStyle(.aqua)

            Button("Save Drink", systemImage: "plus", action: {})
                .tint(.blue)
                .buttonStyle(.aquaProminent)
        }


        ForEach(LabeledColor.systemColors) { systemColor in
            HStack {
                Button { } label: {
                    Text(systemColor.name).frame(width: 160)
                }
                .tint(systemColor.color)
                .buttonStyle(.aqua)

                Button { } label: {
                    Text(systemColor.name).frame(width: 160)
                }
                .tint(systemColor.color)
                .buttonStyle(.aquaProminent)
            }
        }
    }
    .padding()
    .infiniteWidth(alignment: .center)
    .infiniteHeight()
    .background {
        LinearGradient(colors: LabeledColor.systemColors.map { $0.color }.reversed(), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            .opacity(0.2)
    }
}

