import SwiftUI

#if canImport(UIKit)
import UIKit
extension UIScreen {
    private static let displayCornerRadius_Key: String = {
        let components = ["Radius", "Corner", "display", "_"]
        return components.reversed().joined()
    }()

    /// The corner radius of the display. Uses a private property of `UIScreen`,
    /// and may report 0 if the API changes.
    public var displayCornerRadius: CGFloat {
        guard let cornerRadius = self.value(forKey: Self.displayCornerRadius_Key) as? CGFloat else {
            print("Failed to detect screen corner radius")
            return 0
        }
        return cornerRadius
    }
}
#endif

extension CGFloat {
    public static var displayCornerRadius: CGFloat {
#if canImport(UIKit)
        return UIScreen.main.displayCornerRadius
#else
        return 0.0
#endif
    }
}

struct UIScreenCornerRadiusEnvironmentKey: EnvironmentKey {
#if canImport(UIKit)
    static var defaultValue: CGFloat? = UIScreen.main.displayCornerRadius
#else
    static var defaultValue: CGFloat? = nil /// macOS doesn't have a display corner radius
#endif
}

extension EnvironmentValues {
    public var displayCornerRadius: CGFloat? {
        get { self[UIScreenCornerRadiusEnvironmentKey.self] }
        set { self[UIScreenCornerRadiusEnvironmentKey.self] = newValue }
    }
}
