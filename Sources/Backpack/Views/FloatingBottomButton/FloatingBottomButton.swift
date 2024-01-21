import SwiftUI


public struct FloatingBottomButtonStyle: ButtonStyle {
    @Environment(\.tintColor) private var tintColor: Color
    @Environment(\.controlSize) private var controlSize: ControlSize

    private let appearance: FloatingBottomButtonAppearance

    public init(appearance: FloatingBottomButtonAppearance) {
        self.appearance = appearance
    }

    public func makeBody(configuration: Configuration) -> some View {
        makeButtonContent(configuration: configuration)
    }

    @ViewBuilder func makeButtonContent(configuration: Configuration) -> some View {
        let label = configuration.label
            .foregroundStyle(tintColor.contrastingForegroundColor)
            .fontWeight(.bold)
            .font(controlSize.font)
            .imageScale(.large)
            .frame(minHeight: controlSize.minimumButtonHeight)
            .padding(.horizontal, controlSize.horizontalLabelPadding)
            .frame(maxWidth: maxWidth)
            .background {
                makeBackground(configuration: configuration)
            }
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.interactiveSpring, value: configuration.isPressed)

        switch appearance {
            case .fullWidth, .floating:  label
            case .circular:              label.labelStyle(.iconOnly)
        }
    }

    private var maxWidth: CGFloat? {
        switch appearance {
            case .circular, .floating:  nil
            case .fullWidth:            CGFloat.infinity
        }
    }

    @ViewBuilder
    private func makeBackground(configuration: Configuration) -> some View {
        let dropShadow = ShadowStyle.drop(color: Color.black.opacity(0.3), radius: 10.0, x: 0.0, y: 3.0)
        let fillStyle = tintColor.gradient.shadow(dropShadow)

        switch appearance {
            case .fullWidth, .floating:  RoundedRectangle(cornerRadius: 22).fill(fillStyle)
            case .circular:              Circle().fill(fillStyle)
        }
    }
}

public enum FloatingBottomButtonAppearance: Hashable {
    case circular
    case floating
    case fullWidth
}

extension ButtonStyle where Self == FloatingBottomButtonStyle {
    public static func floatingBottom(_ appearance: FloatingBottomButtonAppearance) -> Self {
        FloatingBottomButtonStyle(appearance: appearance)
    }
}

extension View {

    @ViewBuilder
    public func bottomButton<V: View>(
        appearance: FloatingBottomButtonAppearance,
        alignment: HorizontalAlignment = .center,
        color: Color? = nil,
        @ViewBuilder button: @escaping () -> V
    ) -> some View {
        /// Create the button content.
        safeAreaInset(edge: .bottom, alignment: alignment, spacing: nil) {
            HStack(spacing: 8) {
                button()
            }
            .buttonStyle(.floatingBottom(appearance))
            .tintColor(color)
            .controlSize(.large)
            .padding(.horizontal, 8)
        }
    }
}

struct FloatingBottomButtonDemoView: View {
    @State var appearance: FloatingBottomButtonAppearance = .fullWidth

    @State var current: Int = 0
    let count: Int = 100
    var color: Color { Color(hueOutOf360: 360 * Double(current) / 100.0) }

    var body: some View {
        NavigationStack {
            List(0..<100, id: \.self) { i in
                Label {
                    Text("Row \(i)")
                } icon: {
                    Image(systemName: "circle.fill")
                        .imageScale(.large)
                        .foregroundStyle(Color(hueOutOf360: 360 * Double(i) / 100.0))
                }
                .onAppear(perform: {
                    withAnimation(.smooth) {
                        current = i
                    }
                })
            }
            .toolbar {
                ToolbarItem {
                    Picker("Button Style", selection: $appearance) {
                        Text("Circular")
                            .tag(FloatingBottomButtonAppearance.circular)

                        Text("Floating")
                            .tag(FloatingBottomButtonAppearance.floating)

                        Text("Full Width")
                            .tag(FloatingBottomButtonAppearance.fullWidth)
                    }
                }
            }
            .bottomButton(appearance: appearance, alignment: .trailing, color: color) {
                Button("New Item", systemImage: "plus") {
                    // action
                }
            }
            .animation(.spring, value: appearance)
        }
        .tintColor(Color.blue)
    }
}

#Preview {
    FloatingBottomButtonDemoView()
}
