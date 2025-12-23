# OklchColorPicker

A SwiftUI color picker component that uses the OKLCH color space, providing a perceptually uniform way to select colors.

## Features

- **OKLCH Color Space**: Uses the perceptually uniform OKLCH (Oklab Lightness Chroma Hue) color space for more intuitive color selection
- **Interactive Sliders**: Custom sliders for adjusting Hue, Chroma, and Luminance independently
- **Visual Gradients**: Each slider displays a gradient preview showing how the color changes
- **SwiftUI Native**: Built with SwiftUI for seamless integration into modern iOS and macOS apps
- **Binding Support**: Two-way binding with `ColorComponents` for reactive UI updates

## Requirements

- iOS 17.0+ / macOS 14.0+
- Swift 6.0+
- Xcode 16.0+

## Installation

### Swift Package Manager

Add OklchColorPicker to your project using Swift Package Manager:

1. In Xcode, select **File > Add Package Dependencies...**
2. Enter the repository URL: `https://github.com/Bonney/OklchColorPicker`
3. Select the branch or version you want to use

Alternatively, add it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/Bonney/OklchColorPicker", branch: "main")
]
```

Then add it to your target dependencies:

```swift
.target(
    name: "YourTarget",
    dependencies: ["OklchColorPicker"]
)
```

## Usage

### Basic Example

```swift
import SwiftUI
import OklchColorPicker

struct ContentView: View {
    @State private var color = ColorComponents.random
    
    var body: some View {
        VStack {
            OKLCHColorPicker(selection: $color)
                .padding()
        }
    }
}
```

### With Color Preview

```swift
import SwiftUI
import OklchColorPicker

struct ContentView: View {
    @State private var color = ColorComponents.random
    
    var body: some View {
        VStack {
            // Preview the selected color
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
                .frame(height: 100)
            
            // Color picker
            OKLCHColorPicker(selection: $color)
                .padding()
        }
        .padding()
    }
}
```

### Creating ColorComponents

```swift
// Random color
let randomColor = ColorComponents.random

// Specific OKLCH values
let specificColor = ColorComponents(
    luminance: 0.7,  // 0.0 to 1.0 (dark to light)
    chroma: 0.3,     // 0.0 to 0.5 (gray to saturated)
    hue: 180.0       // 0.0 to 360.0 (color wheel)
)

// Convert to SwiftUI Color
let swiftUIColor = specificColor.swiftUIColor

// Get contrasting color for text
let contrastingColor = specificColor.contrastingColor
```

### ColorComponents Properties

The `ColorComponents` struct represents colors in the OKLCH color space:

- **luminance**: Perceived lightness (0.0 to 1.0)
- **chroma**: Saturation from gray to fully saturated (0.0 to 0.5)
- **hue**: Hue angle determining the base color (0.0 to 360.0)

## Understanding OKLCH

OKLCH is a perceptually uniform color space based on human vision. Unlike traditional RGB or HSL:

- **Perceptually Uniform**: Equal distances in the color space correspond to equal perceived color differences
- **Independent Channels**: Adjusting one component doesn't unexpectedly affect others
- **Modern Standard**: Based on Oklab, designed for modern displays and color science

## Dependencies

This package depends on:

- [ChromaKit](https://github.com/HarshilShah/ChromaKit) - For OKLCH color space support
- [Backpack](https://github.com/Bonney/Backpack) - For utility functions

## License

This project is available under the MIT license.
