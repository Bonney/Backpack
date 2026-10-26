import SwiftUI
import Backpack

struct LuminanceGradient: ShapeStyle, Sendable {
    let chroma: Double
    let hue: Double

    func resolve(in environment: EnvironmentValues) -> LinearGradient {
        let stops = 36.0
        let lower = ColorComponents.luminanceRange.lowerBound
        let upper = ColorComponents.luminanceRange.upperBound
        let step = (upper / stops)
        let colors: [Color] = stride(from: lower, through: upper, by: step)
            .map { luminance in
                Color.oklch(luminance, chroma, hue)
            }
        return LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
    }
}
