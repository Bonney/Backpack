import SwiftUI

public extension ColorComponents {
    static let sapphire = ColorComponents(luminance: 0.7055, chroma: 0.1681, hue: 242.7)
    static let turquoise = ColorComponents(luminance: 0.8147, chroma: 0.1387, hue: 202.4)
    static let malachite = ColorComponents(luminance: 0.8216, chroma: 0.198, hue: 156.35)
    static let emerald = ColorComponents(luminance: 0.8119, chroma: 0.2631, hue: 140.32)
    static let citrine = ColorComponents(luminance: 0.8139, chroma: 0.1629, hue: 88.66)
    static let topaz = ColorComponents(luminance: 0.7204, chroma: 0.1738, hue: 57.29)
    static let ruby = ColorComponents(luminance: 0.6326, chroma: 0.2324, hue: 24.42)
    static let amethyst = ColorComponents(luminance: 0.6024, chroma: 0.2615, hue: 301.63)
    static let lapis = ColorComponents(luminance: 0.5715, chroma: 0.2349, hue: 270.84)

    static var gemstones: [ColorComponents] {
        [.sapphire, .turquoise, .malachite, .emerald, .citrine, .topaz, .ruby, .amethyst, .lapis]
    }
}

public extension Color {
    static let sapphire = ColorComponents.sapphire.swiftUIColor
    static let turquoise = ColorComponents.turquoise.swiftUIColor
    static let malachite = ColorComponents.malachite.swiftUIColor
    static let emerald = ColorComponents.emerald.swiftUIColor
    static let citrine = ColorComponents.citrine.swiftUIColor
    static let topaz = ColorComponents.topaz.swiftUIColor
    static let ruby = ColorComponents.ruby.swiftUIColor
    static let amethyst = ColorComponents.amethyst.swiftUIColor
    static let lapis = ColorComponents.lapis.swiftUIColor

    static var gemstoneColors: [Color] {
        [.sapphire, .turquoise, .malachite, .emerald, .citrine, .topaz, .ruby, .amethyst, .lapis]
    }
}

public extension LabeledColor {
    static let sapphire = LabeledColor("Sapphire", components: .sapphire)
    static let turquoise = LabeledColor("Turquoise", components: .turquoise)
    static let malachite = LabeledColor("Malachite", components: .malachite)
    static let emerald = LabeledColor("Emerald", components: .emerald)
    static let citrine = LabeledColor("Citrine", components: .citrine)
    static let topaz = LabeledColor("Topaz", components: .topaz)
    static let ruby = LabeledColor("Ruby", components: .ruby)
    static let amethyst = LabeledColor("Amethyst", components: .amethyst)
    static let lapis = LabeledColor("Lapis", components: .lapis)

    static var gemstones: [LabeledColor] {
        [LabeledColor.sapphire, .turquoise, .malachite, .emerald, .citrine, .topaz, .ruby, .amethyst, .lapis]
    }
}
