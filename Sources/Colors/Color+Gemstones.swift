import SwiftUI

public extension Color {
    static let sapphire = Color("Sapphire", bundle: Bundle.module)
    static let turquoise = Color("Turquoise", bundle: Bundle.module)
    static let malachite = Color("Malachite", bundle: Bundle.module)
    static let emerald = Color("Emerald", bundle: Bundle.module)
    static let citrine = Color("Citrine", bundle: Bundle.module)
    static let topaz = Color("Topaz", bundle: Bundle.module)
    static let ruby = Color("Ruby", bundle: Bundle.module)
    static let amethyst = Color("Amethyst", bundle: Bundle.module)
    static let lapis = Color("Lapis", bundle: Bundle.module)

    static var gemstoneColors: [Color] {
        [.sapphire, .turquoise, .malachite, .emerald, .citrine, .topaz, .ruby, .amethyst, .lapis]
    }
}

public extension LabeledColor {
    static let sapphire = LabeledColor("Sapphire", color: .sapphire)
    static let turquoise = LabeledColor("Turquoise", color: .turquoise)
    static let malachite = LabeledColor("Malachite", color: .malachite)
    static let emerald = LabeledColor("Emerald", color: .emerald)
    static let citrine = LabeledColor("Citrine", color: .citrine)
    static let topaz = LabeledColor("Topaz", color: .topaz)
    static let ruby = LabeledColor("Ruby", color: .ruby)
    static let amethyst = LabeledColor("Amethyst", color: .amethyst)
    static let lapis = LabeledColor("Lapis", color: .lapis)

    static var gemstones: [LabeledColor] {
        [LabeledColor.sapphire, .turquoise, .malachite, .emerald, .citrine, .topaz, .ruby, .amethyst, .lapis]
    }
}
