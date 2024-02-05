import SwiftUI

public extension SwiftUI.ControlSize {
    var minimumButtonHeight: CGFloat {
        switch self {
            case .mini:         26.0
            case .small:        30.0
            case .regular:      40.0
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
            case .regular:      RoundedRectangle(cornerRadius: 12)
            case .large:        RoundedRectangle(cornerRadius: 18)
            case .extraLarge:   RoundedRectangle(cornerRadius: 24)
            @unknown default:   Rectangle()
        }
    }

    var font: Font {
        switch self {
            case .mini:         Font.subheadline.weight(.medium)
            case .small:        Font.subheadline.weight(.medium)
            case .regular:      Font.body.weight(.semibold)
            case .large:        Font.body.weight(.semibold)
            case .extraLarge:   Font.body.weight(.semibold)
            @unknown default:   Font.largeTitle
        }
    }
}
