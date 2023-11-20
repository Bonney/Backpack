import SwiftUI

public extension SwiftUI.ControlSize {
    var minimumButtonHeight: CGFloat {
        switch self {
            case .mini:         28.0
            case .small:        36.0
            case .regular:      44.0
            case .large:        52.0
            case .extraLarge:   60.0
            @unknown default:   200.0
        }
    }
}
