import SwiftUI

extension View {
    /// Set the visibility of the status bar, using the `Visibility` type
    /// with a call site method that better reflects how things like
    /// `persistentSystemOverlays` is called.
    @ViewBuilder
    public func statusBar(_ visibility: Visibility) -> some View {
        let isHidden: Bool = switch visibility {
            case .hidden: true
            default: false
        }

        #if os(iOS)
        self.statusBarHidden(isHidden)
        #else
        self
        #endif
    }
}
