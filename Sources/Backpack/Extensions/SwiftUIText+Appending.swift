import SwiftUI

public extension SwiftUI.Text {
    /// Appends a given String to the end of this Text view.
    func appending(_ suffix: String) -> Text {
        return self.appending {
            Text(verbatim: suffix)
        }
    }

    /// Appends the given Text view to the end of this Text view.
    func appending(@ViewBuilder _ suffix: () -> Text) -> Text {
        return (self + suffix())
    }
}
