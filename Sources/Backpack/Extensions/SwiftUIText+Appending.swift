import SwiftUI

public extension SwiftUI.Text {
    /// Appends a given String to the end of this Text view.
    func appending(_ suffix: String, withSpace: Bool = false) -> Text {
        return self.appending(withSpace: withSpace) {
            Text(verbatim: suffix)
        }
    }

    /// Appends the given Text view to the end of this Text view.
    func appending(withSpace: Bool = false, @ViewBuilder _ suffix: () -> Text) -> Text {
        if withSpace {
            return self + Text(" ") + suffix()
        }
        return self + suffix()
    }
}
