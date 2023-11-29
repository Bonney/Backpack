import SwiftUI

public extension SwiftUI.ControlSize {
    var minimumButtonHeight: CGFloat {
        switch self {
            case .mini:         26.0
            case .small:        30.0
            case .regular:      36.0
            case .large:        52.0
            case .extraLarge:   56.0
            @unknown default:   200.0
        }
    }

    var horizontalLabelPadding: Double {
        switch self {
            case .mini:         10
            case .small:        10
            case .regular:      12
            case .large:        20
            case .extraLarge:   20
            @unknown default:   99
        }
    }

    var controlShape: any Shape {
        switch self {
            case .mini:         Capsule()
            case .small:        Capsule()
            case .regular:      RoundedRectangle(cornerRadius: 8)
            case .large:        RoundedRectangle(cornerRadius: 12)
            case .extraLarge:   Capsule()
            @unknown default:   Rectangle()
        }
    }

    var font: Font {
        switch self {
            case .mini:         Font.subheadline
            case .small:        Font.subheadline
            case .regular:      Font.body
            case .large:        Font.body
            case .extraLarge:   Font.body
            @unknown default:   Font.largeTitle
        }
    }
}
