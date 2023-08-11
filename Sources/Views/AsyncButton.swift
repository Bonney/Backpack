import SwiftUI

public struct AsyncButton<Label: View>: View {
    // inspired by https://github.com/lorenzofiamingo/swiftui-async-button/blob/main/Sources/AsyncButton/AsyncButton.swift

    public enum LoadingIndicatorStyle {
        case compact
        case adjacent(alignment: HorizontalAlignment)
    }

    private let role: ButtonRole?
    private let loadingIndicatorStyle: AsyncButton.LoadingIndicatorStyle
    private let action: () async throws -> Void
    private let label: () -> Label

    @State private var isRunningAsync: Bool = false

    // MARK: - View Body

    public var body: some View {
        Button(role: self.role) {
            Task {
                isRunningAsync = true
                try await action()
                isRunningAsync = false
            }
        } label: {
            switch loadingIndicatorStyle {
                case .compact:
                    compactLabel()
                case .adjacent(let alignment):
                    adjacentLabel(alignment)
            }
        }
        .disabled(isRunningAsync)
    }

    @ViewBuilder
    private func buttonLabel() -> some View {
        switch loadingIndicatorStyle {
            case .compact:
                compactLabel()
            case .adjacent(let alignment):
                adjacentLabel(alignment)
        }
    }

    @ViewBuilder private func compactLabel() -> some View {
        label()
            .overlay {
                if isRunningAsync { ProgressView() }
            }
    }

    @ViewBuilder
    private func adjacentLabel(_ alignment: HorizontalAlignment) -> some View {
        HStack {
            if alignment == .leading && isRunningAsync {
                ProgressView()
            }

            label()

            if alignment == .trailing && isRunningAsync {
                ProgressView()
            }
        }
    }

    // MARK: - Initializers

    // Initialize with a ViewBuilder for the label.
    public init(
        role: ButtonRole? = nil,
        loadingIndicatorStyle: AsyncButton.LoadingIndicatorStyle = .compact,
        action: @escaping () async throws -> Void,
        @ViewBuilder label: @escaping () -> Label
    ) {
        self.role = role
        self.loadingIndicatorStyle = loadingIndicatorStyle
        self.action = action
        self.label = label
    }

}

extension AsyncButton where Label == Text {
    // Initialize with a String key.
    public init(
        _ titleKey: LocalizedStringKey,
        role: ButtonRole? = nil,
        loadingIndicatorStyle: AsyncButton.LoadingIndicatorStyle = .compact,
        action: @escaping () async throws -> Void) {
            self.init(role: role, loadingIndicatorStyle: loadingIndicatorStyle, action: action, label: {
                Text(titleKey)
            })
        }

    // Initialize with a String key.
    public init<S: StringProtocol>(
        _ title: S,
        role: ButtonRole? = nil,
        loadingIndicatorStyle: AsyncButton.LoadingIndicatorStyle = .compact,
        action: @escaping () async throws -> Void) {
            self.init(role: role, loadingIndicatorStyle: loadingIndicatorStyle, action: action, label: {
                Text(title)
            })
        }
}

extension AsyncButton {
    // Method for replacing the loading indicator style
    public func loadingIndicatorStyle(_ style: AsyncButton.LoadingIndicatorStyle) -> AsyncButton {
        AsyncButton(role: self.role, loadingIndicatorStyle: style, action: self.action, label: self.label)
    }
}

struct AsyncButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {

            AsyncButton {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
            } label: {
                Text("AsyncButton")
            }
            .loadingIndicatorStyle(.adjacent(alignment: .leading))
            .buttonStyle(.bordered)

            AsyncButton {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
            } label: {
                Text("AsyncButton")
            }
            .loadingIndicatorStyle(.adjacent(alignment: .trailing))
            .buttonStyle(.bordered)

            AsyncButton {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
            } label: {
                Text("Send Message")
            }
            .loadingIndicatorStyle(.compact)
            .buttonStyle(.borderedProminent)

        }
    }
}
