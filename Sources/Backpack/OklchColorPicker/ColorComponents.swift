import SwiftUI

/// A structure representing color components in the OKLCH color space.
public struct ColorComponents: ShapeStyle, Hashable, Codable, Sendable, Equatable {
    /// Perceived lightness to the human eye.
    public var luminance: Double
    /// Saturation, from gray to fully saturated.
    public var chroma: Double
    /// The hue angle to determine the base color.
    public var hue: Double

    public init(luminance: Double, chroma: Double, hue: Double) {
        self.luminance = luminance
        self.chroma = chroma
        self.hue = hue
    }

    public var swiftUIColor: Color {
        Color.oklch(luminance, chroma, hue)
    }

    public var contrastingColor: Color {
        swiftUIColor.contrastingForegroundColor()
    }

    public func resolve(in environment: EnvironmentValues) -> Color {
        swiftUIColor
    }

    public static func == (lhs: ColorComponents, rhs: ColorComponents) -> Bool {
        return (lhs.luminance == rhs.luminance && lhs.chroma == rhs.chroma && lhs.hue == rhs.hue)
    }
}

extension ColorComponents {
    public static var random: ColorComponents {
        ColorComponents(
            luminance: Double.random(in: ColorComponents.luminanceRange),
            chroma: Double.random(in: ColorComponents.chromaRange),
            hue: Double.random(in: ColorComponents.hueRange)
        )
    }
}

extension ColorComponents {
    public var gradient: AnyGradient {
        self.swiftUIColor.gradient
    }
}

extension ColorComponents {
    public static let luminanceRange: ClosedRange<Double> = 0.0...1.0
    public static let chromaRange: ClosedRange<Double> = 0.0...0.5
    public static let hueRange: ClosedRange<Double> = 0.0...360.0
}

