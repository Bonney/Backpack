import SwiftUI

public enum DelayedAppearancePresentationStyle {
    case hidden
    case progress
    case loading(value: Double)
}

public struct AppearanceDelayViewModifier: ViewModifier {
    let delay: TimeInterval
    let style: DelayedAppearancePresentationStyle

    @State private var isVisible: Bool = false

    public init(_ delay: TimeInterval, style: DelayedAppearancePresentationStyle) {
        self.delay = delay
        self.style = style
    }

    public func body(content: Content) -> some View {
        content
            .opaque(when: isVisible)
            .overlay {
                Group {
                    switch style {
                        case .hidden:               EmptyView()
                        case .progress:             ProgressView()
                        case .loading(let value):   ProgressView(value: value)
                    }
                }
                .opaque(when: isVisible, equals: false)
            }
            .animation(.easeOut, value: isVisible)
            .task {
                try? await Task.sleep(for: .seconds(delay))
                isVisible = true
            }
    }
}

extension View {
    public func appearanceDelay(_ value: TimeInterval, style: DelayedAppearancePresentationStyle = .hidden) -> some View {
        return modifier(AppearanceDelayViewModifier(value, style: style))
    }
}

public struct ContentLoadingViewModifier: ViewModifier {
    let title: String
    let description: String?
    var isLoading: Bool

    public init(title: String, description: String?, isLoading: Bool) {
        self.title = title
        self.description = description
        self.isLoading = isLoading
    }

    public func body(content: Content) -> some View {
        content
            .opaque(when: isLoading, equals: false)
            .overlay {
                loadingView
                    .opaque(when: isLoading)
            }
            .animation(.easeOut, value: isLoading)
    }

    private var loadingView: some View {
        ContentUnavailableView {
            Label {
                Text(title)
            } icon: {
            }
        } description: {
            Text(description ?? "")
            ProgressView(value: 0.5)
        }
    }
}

extension View {
    public func contentLoading(title: String = "Loading", description: String? = nil, isLoading: Bool) -> some View {
        return modifier(ContentLoadingViewModifier(title: title, description: description, isLoading: isLoading))
    }
}


struct ContentLoadingViewModifierExampleView: View {
    @State private var numbers: [Double] = []

    var body: some View {
        List(numbers, id: \.self) { number in
            Text(number, format: .number)
        }
        .contentLoading(title: "Loading Files...", isLoading: numbers.isEmpty)
        .refreshable { await loadNumbers() }
        .task(id: "loadNumbers") { await loadNumbers() }
    }

    private func loadNumbers() async {
        numbers = []
        try? await Task.sleep(for: .seconds(3))
        numbers = (0...10).shuffled().map { Double($0) }
    }
}

#Preview {
    ContentLoadingViewModifierExampleView()
}
