# Backpack 🎒

"The stuff I take with me everywhere."

`Backpack` is my personal Swift and SwiftUI toolkit, full of the little things I carry with me between projects.

> "It's a living beverage."

– Merlin Mann (I *think* Merlin said that, anyway.)

**Everything in here has been mostly, kind of, sort of tested. A little bit. But not much.** And not with real tests.

Take it, use it, contribute if you want!
## OklchColorPicker

The package also ships a second library product, `OklchColorPicker`: a SwiftUI color picker built on the perceptually uniform OKLCH color space. Its OKLCH color math comes from [ChromaKit](https://github.com/HarshilShah/ChromaKit) by Harshil Shah (MIT), which is vendored into `Backpack` under `Sources/Backpack/ChromaKit`. The package has no external dependencies.

```swift
.product(name: "OklchColorPicker", package: "Backpack")
```

```swift
import OklchColorPicker

struct ContentView: View {
    @State private var color = ColorComponents.random

    var body: some View {
        OKLCHColorPicker(selection: $color, displayedComponents: .all)
            .padding()
            .background(color)
    }
}
```

`ColorComponents` holds `luminance` (0–1), `chroma` (0–0.5) and `hue` (0–360). It's a `ShapeStyle`, so you can use it anywhere a color fits, and it exposes `swiftUIColor`, `contrastingColor` and `gradient`.
