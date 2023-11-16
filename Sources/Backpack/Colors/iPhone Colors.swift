//
//  File.swift
//  
//
//  Created by Matt Bonney on 9/27/23.
//

import SwiftUI

public extension Color {

    static let iPhoneColorSets: [[Color]] = [
        Color.iPhone15.allColors, Color.iPhone14.allColors, Color.iPhone13.allColors, Color.iPhone12.allColors, Color.iPhone11.allColors, Color.iPhoneXR.allColors
    ]

    static let iPhoneColors: [Color] = Color.iPhone15.allColors + Color.iPhone14.allColors + Color.iPhone13.allColors + Color.iPhone12.allColors + Color.iPhone11.allColors + Color.iPhoneXR.allColors

    /// Colors that match the back glass of the iPhone 15/15 Plus.
    enum iPhone15 {
        static let allColors: [Color] = [blue, green, yellow, pink]
        /// A desaturated blue.
        static let blue = Color(red: 0.953, green: 0.973, blue: 0.976, opacity: 1.000)
        /// A desaturated green.
        static let green = Color(red: 0.941, green: 0.957, blue: 0.890, opacity: 1.000)
        /// A desaturated yellow.
        static let yellow = Color(red: 0.988, green: 0.973, blue: 0.867, opacity: 1.000)
        /// A desaturated pink.
        static let pink = Color(red: 1.000, green: 0.882, blue: 0.882, opacity: 1.000)
    }

    /// Colors that match the back glass of the iPhone 14/14 Plus.
    enum iPhone14 {
        static let allColors: [Color] = [red, blue, purple, yellow]
        /// Vibrant cherry red.
        static let red = Color(red: 0.875, green: 0.035, blue: 0.153, opacity: 1.000)
        /// Cool slate blue.
        static let blue = Color(red: 0.584, green: 0.667, blue: 0.741, opacity: 1.000)
        /// Pale lavender.
        static let purple = Color(red: 0.902, green: 0.859, blue: 0.922, opacity: 1.000)
        /// Bright golden yellow.
        static let yellow = Color(red: 0.992, green: 0.890, blue: 0.408, opacity: 1.000)
    }

    /// Colors that match the back glass of the iPhone 13/13 mini.
    enum iPhone13 {
        static let allColors: [Color] = [red, blue, pink, green]
        /// Deep scarlet red.
        static let red = Color(red: 0.569, green: 0.004, blue: 0.063, opacity: 1.000)
        /// Teal blue-green.
        static let blue = Color(red: 0.122, green: 0.361, blue: 0.475, opacity: 1.000)
        /// Soft rosy pink.
        static let pink = Color(red: 0.969, green: 0.855, blue: 0.831, opacity: 1.000)
        /// Deep forest green.
        static let green = Color(red: 0.204, green: 0.271, blue: 0.200, opacity: 1.000)
    }

    /// Colors that match the back glass of the iPhone 12/12 mini.
    enum iPhone12 {
        static let allColors: [Color] = [red, green, blue, purple]
        /// Vivid crimson.
        static let red = Color(red: 0.871, green: 0.200, blue: 0.204, opacity: 1.000)
        /// Pale, minty green.
        static let green = Color(red: 0.855, green: 0.941, blue: 0.839, opacity: 1.000)
        /// Deep navy blue.
        static let blue = Color(red: 0.016, green: 0.204, blue: 0.345, opacity: 1.000)
        /// Bright lavender.
        static let purple = Color(red: 0.725, green: 0.678, blue: 0.910, opacity: 1.000)
    }

    /// Colors that match the back glass of the iPhone 11.
    enum iPhone11 {
        static let allColors: [Color] = [green, yellow, purple, red]
        /// Seafoam green.
        static let green = Color(red: 0.651, green: 0.851, blue: 0.765, opacity: 1.000)
        /// Bright pale yellow.
        static let yellow = Color(red: 0.992, green: 0.898, blue: 0.502, opacity: 1.000)
        /// A muted lilac color.
        static let purple = Color(red: 0.796, green: 0.773, blue: 0.835, opacity: 1.000)
        /// Mid-tone burgundy red.
        static let red = Color(red: 0.710, green: 0.047, blue: 0.173, opacity: 1.000)
    }

    /// Colors that match the back glass of the iPhone XR.
    enum iPhoneXR {
        static let allColors: [Color] = [red, coral, yellow, blue]
        /// Deep maroon.
        static let red = Color(red: 0.557, green: 0.004, blue: 0.055, opacity: 1.000)
        /// Vibrant pinkish-orange.
        static let coral = Color(red: 0.976, green: 0.365, blue: 0.282, opacity: 1.000)
        /// Sunshine yellow.
        static let yellow = Color(red: 0.969, green: 0.812, blue: 0.286, opacity: 1.000)
        /// Cerulean blue.
        static let blue = Color(red: 0.243, green: 0.655, blue: 0.882, opacity: 1.000)
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

