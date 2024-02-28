import SwiftUI

extension Color {
    public static let hyperColors = [
        Color(ColorResource.hyperRed),
        Color(ColorResource.hyperPink),
        Color(ColorResource.hyperPurple),
        Color(ColorResource.hyperIndigo),
        Color(ColorResource.hyperBlue),
        Color(ColorResource.hyperTeal),
        Color(ColorResource.hyperCyan),
        Color(ColorResource.hyperGreen),
        Color(ColorResource.hyperYellow),
        Color(ColorResource.hyperOrange)
    ]
}

extension Color {
    public enum hyper {
        public static let red = Color("HyperRed", bundle: Bundle.module)
        public static let pink = Color("HyperPink", bundle: Bundle.module)
        public static let purple = Color("HyperPurple", bundle: Bundle.module)
        public static let indigo = Color("HyperIndigo", bundle: Bundle.module)
        public static let blue = Color("HyperBlue", bundle: Bundle.module)
        public static let teal = Color("HyperTeal", bundle: Bundle.module)
        public static let cyan = Color("HyperCyan", bundle: Bundle.module)
        public static let green = Color("HyperGreen", bundle: Bundle.module)
        public static let yellow = Color("HyperYellow", bundle: Bundle.module)
        public static let orange = Color("HyperOrange", bundle: Bundle.module)
    }
}

//
//public extension Color {
//    static let sapphire = Color("Sapphire", bundle: Bundle.module)
//    static let turquoise = Color("Turquoise", bundle: Bundle.module)
//    static let malachite = Color("Malachite", bundle: Bundle.module)
//    static let emerald = Color("Emerald", bundle: Bundle.module)
//    static let citrine = Color("Citrine", bundle: Bundle.module)
//    static let topaz = Color("Topaz", bundle: Bundle.module)
//    static let ruby = Color("Ruby", bundle: Bundle.module)
//    static let amethyst = Color("Amethyst", bundle: Bundle.module)
//    static let lapis = Color("Lapis", bundle: Bundle.module)
//
//    static var gemstoneColors: [Color] {
//        [.sapphire, .turquoise, .malachite, .emerald, .citrine, .topaz, .ruby, .amethyst, .lapis]
//    }
//}
