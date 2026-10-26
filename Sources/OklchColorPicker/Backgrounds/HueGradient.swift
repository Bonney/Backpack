import SwiftUI
import Backpack

struct HueGradient: ShapeStyle, Sendable {

    func resolve(in environment: EnvironmentValues) -> LinearGradient {
        let stops = 36.0
        let lower = ColorComponents.hueRange.lowerBound
        let upper = ColorComponents.hueRange.upperBound
        let step = (upper / stops)
        let colors: [Color] = stride(from: lower, through: upper, by: step)
            .map { hue in
                Color.oklch(0.6, 0.4, hue)
            }
        return LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
    }
}

#Preview {
    VStack {
        Rectangle()
            .fill(HueGradient())
            .frame(height: 44)
    }
    .padding()
}
