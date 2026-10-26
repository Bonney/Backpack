import SwiftUI
import ChromaKit

struct ChromaGradient: ShapeStyle, Sendable {
    let luminance: Double
    let hue: Double

    func resolve(in environment: EnvironmentValues) -> LinearGradient {
        let stops = 36.0
        let lower = ColorComponents.chromaRange.lowerBound
        let upper = ColorComponents.chromaRange.upperBound
        let step = (upper / stops)
        let colors: [Color] = stride(from: lower, through: upper, by: step)
            .map { chroma in
                Color.oklch(luminance, chroma, hue)
            }
        return LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
    }
}
