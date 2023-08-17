# Backpack 🎒

"The stuff I take with me everywhere."

`Backpack` is my personal Swift SwiftUI toolkit, full of the little things I carry with me between projects.

> "It's a living beverage."

– Merlin Mann (I *think* Merlin said that, anyway.)

## Views

Some of these tools are small things to make working with SwiftUI even faster, or to fill in missing gaps in the standard toolkit. Many simply reduce the need for explicitly initializing icons or labels, or sometimes eliminate writing trailing closures .

One example is an initializer for SwiftUI's `Button` that simply takes an SF Symbol name for icon-only buttons:

```swift
// Backpack
Button(systemImage: "star") {
  favorite.toggle()
}

// SwiftUI
Button {
  favorite.toggle()
} label: {
  Image(systemName: "star.fill")
}
```

Another commonly reused UI element that is worth extracting to it's own component is the "more" or "menu" button, often denoted with an ellipsis SF Symbol.

This element has been extracted to one View: `EllipsisMenu`:

```swift
// Backpack
EllipsisMenu {
 // Standard `Menu` content, including Text, Buttons, Sections, etc.
}

// SwiftUI
Menu {
 /// Content...
} label: {
   Image(systemName: "ellipsis.circle")
}
```

Other useful Views and View Modifiers include `IntSlider`, a standard SwiftUI slider for integer values, and `.infiniteHeight(alignment:)`/`.infiniteWidth(alignment:)`, which are much nicer to write than `.frame(maxWidth: .infinity, alignment: ...)`.

## Timeframe

`Timeframe` is a small framework for working with date ranges, developed for working with predicates, HealthKit queries, and Swift charts.

## Colors

`LabeledColor` allows you to pair SwiftUI's `Color` with a given name, useful for theme and color pickers. The package also includes two sets of Labeled Colors: `LabeledColor.gemStones` returns a set of hand-tuned theme colors, while `LabeledColor.watchOSColors` provides an (out-of-date) set of official watchOS tint colors along with their names.
