//
//  File.swift
//  
//
//  Created by Matt Bonney on 9/27/23.
//

import SwiftUI

public extension ColorComponents {

    static let iPhoneColorSets: [[ColorComponents]] = [
        iPhone15.allColors, iPhone14.allColors, iPhone13.allColors, iPhone12.allColors, iPhone11.allColors, iPhoneXR.allColors
    ]

    static let iPhoneColors: [ColorComponents] = iPhoneColorSets.flatMap { $0 }

    /// Colors that match the back glass of the iPhone 15/15 Plus.
    enum iPhone15 {
        public static let allColors: [ColorComponents] = [blue, green, yellow, pink]
        /// A desaturated blue.
        public static let blue = ColorComponents(luminance: 0.9758, chroma: 0.0055, hue: 207.64)
        /// A desaturated green.
        public static let green = ColorComponents(luminance: 0.9595, chroma: 0.0229, hue: 117.75)
        /// A desaturated yellow.
        public static let yellow = ColorComponents(luminance: 0.9754, chroma: 0.0355, hue: 100.42)
        /// A desaturated pink.
        public static let pink = ColorComponents(luminance: 0.9341, chroma: 0.0333, hue: 17.76)
    }

    /// Colors that match the back glass of the iPhone 14/14 Plus.
    enum iPhone14 {
        public static let allColors: [ColorComponents] = [red, blue, purple, yellow]
        /// Vibrant cherry red.
        public static let red = ColorComponents(luminance: 0.5716, chroma: 0.2288, hue: 24.88)
        /// Cool slate blue.
        public static let blue = ColorComponents(luminance: 0.7283, chroma: 0.0362, hue: 245.23)
        /// Pale lavender.
        public static let purple = ColorComponents(luminance: 0.905, chroma: 0.0246, hue: 315.28)
        /// Bright golden yellow.
        public static let yellow = ColorComponents(luminance: 0.9139, chroma: 0.1443, hue: 97.46)
    }

    /// Colors that match the back glass of the iPhone 13/13 mini.
    enum iPhone13 {
        public static let allColors: [ColorComponents] = [red, blue, pink, green]
        /// Deep scarlet red.
        public static let red = ColorComponents(luminance: 0.4139, chroma: 0.1677, hue: 26.13)
        /// Teal blue-green.
        public static let blue = ColorComponents(luminance: 0.4497, chroma: 0.0774, hue: 233.1)
        /// Soft rosy pink.
        public static let pink = ColorComponents(luminance: 0.9108, chroma: 0.0335, hue: 31.83)
        /// Deep forest green.
        public static let green = ColorComponents(luminance: 0.3702, chroma: 0.0375, hue: 143.35)
    }

    /// Colors that match the back glass of the iPhone 12/12 mini.
    enum iPhone12 {
        public static let allColors: [ColorComponents] = [red, green, blue, purple]
        /// Vivid crimson.
        public static let red = ColorComponents(luminance: 0.5913, chroma: 0.2071, hue: 26.06)
        /// Pale, minty green.
        public static let green = ColorComponents(luminance: 0.9319, chroma: 0.0417, hue: 140.76)
        /// Deep navy blue.
        public static let blue = ColorComponents(luminance: 0.3164, chroma: 0.08, hue: 247.39)
        /// Bright lavender.
        public static let purple = ColorComponents(luminance: 0.778, chroma: 0.0842, hue: 293.64)
    }

    /// Colors that match the back glass of the iPhone 11.
    enum iPhone11 {
        public static let allColors: [ColorComponents] = [green, yellow, purple, red]
        /// Seafoam green.
        public static let green = ColorComponents(luminance: 0.8436, chroma: 0.0611, hue: 166.7)
        /// Bright pale yellow.
        public static let yellow = ColorComponents(luminance: 0.9208, chroma: 0.1243, hue: 96.33)
        /// A muted lilac color.
        public static let purple = ColorComponents(luminance: 0.8333, chroma: 0.0227, hue: 302.7)
        /// Mid-tone burgundy red.
        public static let red = ColorComponents(luminance: 0.4925, chroma: 0.1928, hue: 21.12)
    }

    /// Colors that match the back glass of the iPhone XR.
    enum iPhoneXR {
        public static let allColors: [ColorComponents] = [red, coral, yellow, blue]
        /// Deep maroon.
        public static let red = ColorComponents(luminance: 0.4075, chroma: 0.1652, hue: 26.49)
        /// Vibrant pinkish-orange.
        public static let coral = ColorComponents(luminance: 0.6798, chroma: 0.1945, hue: 30.5)
        /// Sunshine yellow.
        public static let yellow = ColorComponents(luminance: 0.8662, chroma: 0.1528, hue: 91.93)
        /// Cerulean blue.
        public static let blue = ColorComponents(luminance: 0.6934, chroma: 0.1271, hue: 237.1)
    }
}

public extension Color {

    static let iPhoneColorSets: [[Color]] = ColorComponents.iPhoneColorSets.map { $0.map(\.swiftUIColor) }

    static let iPhoneColors: [Color] = ColorComponents.iPhoneColors.map(\.swiftUIColor)

    /// Colors that match the back glass of the iPhone 15/15 Plus.
    enum iPhone15 {
        public static let allColors: [Color] = ColorComponents.iPhone15.allColors.map(\.swiftUIColor)
        /// A desaturated blue.
        public static let blue = ColorComponents.iPhone15.blue.swiftUIColor
        /// A desaturated green.
        public static let green = ColorComponents.iPhone15.green.swiftUIColor
        /// A desaturated yellow.
        public static let yellow = ColorComponents.iPhone15.yellow.swiftUIColor
        /// A desaturated pink.
        public static let pink = ColorComponents.iPhone15.pink.swiftUIColor
    }

    /// Colors that match the back glass of the iPhone 14/14 Plus.
    enum iPhone14 {
        public static let allColors: [Color] = ColorComponents.iPhone14.allColors.map(\.swiftUIColor)
        /// Vibrant cherry red.
        public static let red = ColorComponents.iPhone14.red.swiftUIColor
        /// Cool slate blue.
        public static let blue = ColorComponents.iPhone14.blue.swiftUIColor
        /// Pale lavender.
        public static let purple = ColorComponents.iPhone14.purple.swiftUIColor
        /// Bright golden yellow.
        public static let yellow = ColorComponents.iPhone14.yellow.swiftUIColor
    }

    /// Colors that match the back glass of the iPhone 13/13 mini.
    enum iPhone13 {
        public static let allColors: [Color] = ColorComponents.iPhone13.allColors.map(\.swiftUIColor)
        /// Deep scarlet red.
        public static let red = ColorComponents.iPhone13.red.swiftUIColor
        /// Teal blue-green.
        public static let blue = ColorComponents.iPhone13.blue.swiftUIColor
        /// Soft rosy pink.
        public static let pink = ColorComponents.iPhone13.pink.swiftUIColor
        /// Deep forest green.
        public static let green = ColorComponents.iPhone13.green.swiftUIColor
    }

    /// Colors that match the back glass of the iPhone 12/12 mini.
    enum iPhone12 {
        public static let allColors: [Color] = ColorComponents.iPhone12.allColors.map(\.swiftUIColor)
        /// Vivid crimson.
        public static let red = ColorComponents.iPhone12.red.swiftUIColor
        /// Pale, minty green.
        public static let green = ColorComponents.iPhone12.green.swiftUIColor
        /// Deep navy blue.
        public static let blue = ColorComponents.iPhone12.blue.swiftUIColor
        /// Bright lavender.
        public static let purple = ColorComponents.iPhone12.purple.swiftUIColor
    }

    /// Colors that match the back glass of the iPhone 11.
    enum iPhone11 {
        public static let allColors: [Color] = ColorComponents.iPhone11.allColors.map(\.swiftUIColor)
        /// Seafoam green.
        public static let green = ColorComponents.iPhone11.green.swiftUIColor
        /// Bright pale yellow.
        public static let yellow = ColorComponents.iPhone11.yellow.swiftUIColor
        /// A muted lilac color.
        public static let purple = ColorComponents.iPhone11.purple.swiftUIColor
        /// Mid-tone burgundy red.
        public static let red = ColorComponents.iPhone11.red.swiftUIColor
    }

    /// Colors that match the back glass of the iPhone XR.
    enum iPhoneXR {
        public static let allColors: [Color] = ColorComponents.iPhoneXR.allColors.map(\.swiftUIColor)
        /// Deep maroon.
        public static let red = ColorComponents.iPhoneXR.red.swiftUIColor
        /// Vibrant pinkish-orange.
        public static let coral = ColorComponents.iPhoneXR.coral.swiftUIColor
        /// Sunshine yellow.
        public static let yellow = ColorComponents.iPhoneXR.yellow.swiftUIColor
        /// Cerulean blue.
        public static let blue = ColorComponents.iPhoneXR.blue.swiftUIColor
    }
}

struct ColorGrid: View {
    let colorSet: [Color]
    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                ForEach(colorSet, id: \.self) { color in
                    Rectangle()
                        .frame(height: 100)
                        .foregroundStyle(color.gradient)
                }
            }
        }
    }
}

struct ColorDemo: View {
    var body: some View {
        ScrollView {
            ForEach(Color.iPhoneColorSets, id: \.self) { set in
                ColorGrid(colorSet: set)
                Divider()
            }
        }
    }
}

struct ColorDemoPreview: PreviewProvider {
    static var previews: some View {
        ColorDemo()
    }
}

