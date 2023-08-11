import SwiftUI

// Shorthands for .frame(maxWidth: .infinity, alignment: .leading) and so on.

/// A view modifier that sets the maximum width of a view to infinity.
public struct InfiniteWidth: ViewModifier {
    /// The alignment of the content within the view.
    var alignment: Alignment

    /// Modifies the content by setting its maximum width to infinity and applying the specified alignment.
    public func body(content: Content) -> some View {
        content.frame(maxWidth: .infinity, alignment: alignment)
    }
}

/// A view modifier that sets the maximum height of a view to infinity.
public struct InfiniteHeight: ViewModifier {
    /// The alignment of the content within the view.
    var alignment: Alignment

    /// Modifies the content by setting its maximum height to infinity and applying the specified alignment.
    public func body(content: Content) -> some View {
        content.frame(maxHeight: .infinity, alignment: alignment)
    }
}

public extension View {
    /// Returns a view with infinite width and the specified alignment.
    func infiniteWidth(alignment: Alignment = .leading) -> some View {
       modifier(InfiniteWidth(alignment: alignment))
    }

    /// Returns a view with infinite height and the specified alignment.
    func infiniteHeight(alignment: Alignment = .center) -> some View {
        modifier(InfiniteHeight(alignment: alignment))
    }
}

