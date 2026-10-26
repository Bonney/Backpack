import SwiftUI

extension ColorComponents {
    public enum hyper {
        public static let red = ColorComponents(luminance: 0.6601, chroma: 0.2683, hue: 31.52)
        public static let pink = ColorComponents(luminance: 0.7108, chroma: 0.272, hue: 321.01)
        public static let purple = ColorComponents(luminance: 0.5566, chroma: 0.2688, hue: 281.66)
        public static let indigo = ColorComponents(luminance: 0.5564, chroma: 0.2609, hue: 263.63)
        public static let blue = ColorComponents(luminance: 0.716, chroma: 0.1856, hue: 233.86)
        public static let teal = ColorComponents(luminance: 0.7696, chroma: 0.1899, hue: 170.42)
        public static let cyan = ColorComponents(luminance: 0.8868, chroma: 0.195, hue: 187.97)
        public static let green = ColorComponents(luminance: 0.742, chroma: 0.308, hue: 145.59)
        public static let yellow = ColorComponents(luminance: 0.9057, chroma: 0.2044, hue: 99.81)
        public static let orange = ColorComponents(luminance: 0.7641, chroma: 0.1962, hue: 50.65)

        public static let allColors: [ColorComponents] = [
            red,
            pink,
            purple,
            indigo,
            blue,
            teal,
            cyan,
            green,
            yellow,
            orange
        ]
    }
}

extension Color {
    public static let hyperColors: [Color] = ColorComponents.hyper.allColors.map(\.swiftUIColor)
}

extension Color {
    public enum hyper {
        public static let red = ColorComponents.hyper.red.swiftUIColor
        public static let pink = ColorComponents.hyper.pink.swiftUIColor
        public static let purple = ColorComponents.hyper.purple.swiftUIColor
        public static let indigo = ColorComponents.hyper.indigo.swiftUIColor
        public static let blue = ColorComponents.hyper.blue.swiftUIColor
        public static let teal = ColorComponents.hyper.teal.swiftUIColor
        public static let cyan = ColorComponents.hyper.cyan.swiftUIColor
        public static let green = ColorComponents.hyper.green.swiftUIColor
        public static let yellow = ColorComponents.hyper.yellow.swiftUIColor
        public static let orange = ColorComponents.hyper.orange.swiftUIColor
    }
}
