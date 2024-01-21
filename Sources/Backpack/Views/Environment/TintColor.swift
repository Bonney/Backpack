import SwiftUI

/// A custom environment key that can be used to set a tint color for the view hierarchy.
public struct TintColorEnvironmentKey: EnvironmentKey {
    public static let defaultValue: Color = Color.accentColor
}

extension EnvironmentValues {
    /// The tint color for the view hierarchy.
    public var tintColor: Color {
        get { self[TintColorEnvironmentKey.self] }
        set { self[TintColorEnvironmentKey.self] = newValue }
    }
}

extension View {
    /// Set both SwiftUI's `.tint` modifier (which has no good environment values),
    /// as well as my custom `tintColor` environment value.
    public func tintColor(_ color: Color) -> some View {
        self
            .environment(\.tintColor, color)
            .tint(color)
    }
}
