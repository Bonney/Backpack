import SwiftUI

extension View {
    /// Places the View in a ZStack with a hidden circular SFSymbol to help with alignment.
    /// You'll typically want to apply this modifier directly to your `Image(systemName:)`
    /// to ensure that things such as Font Size and Image Scale are applied to each Symbol.
    public func withAlignmentSymbol() -> some View {
        ZStack {
            Image(systemName: "circle").hidden()
            self
        }
    }
}
