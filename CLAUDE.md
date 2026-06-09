# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Backpack is a personal Swift Package — a library of SwiftUI views, extensions, color assets, and small utilities the author reuses across projects. Single library product (`Backpack`), no external dependencies.

Platforms: iOS 17+, macOS 14+, watchOS 10+. Swift tools 5.9.

## Commands

```bash
# Build
swift build

# Run all tests
swift test

# Run a single test class or method
swift test --filter TimeframeTests
swift test --filter TimeframeTests/testTodayDateRange
```

When working in Xcode, open the package folder directly — there is no `.xcodeproj`, just `Package.swift` and the `.swiftpm` workspace.

## Architecture

Everything lives under `Sources/Backpack/`, organized by topic rather than by Swift type. Subdirectories are the conceptual map:

- **`Timeframe/`** — `Timeframe` enum (today / thisWeek / thisMonth / thisYear / from / allTime) plus extensions for `dateRange`, `Predicate` building (`Timeframe+Predicate.swift`), and Swift Charts axis helpers (`Timeframe+Charts.swift`). Designed for HealthKit-style range queries. Conforms to `Sendable`, `Hashable`, `Identifiable`, `CustomStringConvertible`.
- **`LocalNotifications/`** — `@MainActor` singleton (`LocalNotifications.shared`) wrapping `UNUserNotificationCenter` with authorization, scheduling, and removal. `NotificationContent`, `NotificationTrigger`, `NotificationAction` are the value types you pass in. Uses `os.Logger` with subsystem `LocalNotifications`.
- **`Colors/`** — Two palettes shipped as asset catalogs and exposed via namespaces: `Color.hyper.*` (vibrant) and `Color.gemstones` collection. `UXColor` is a cross-platform `UIColor`/`NSColor` typealias with luminance helpers (`isBright`, `contrastingForegroundColor`). Asset lookups must use `bundle: Bundle.module` because resources are processed as package resources (`Package.swift` declares `.process("Colors/Colors.xcassets")`).
- **`Extensions/`** — Foundation/SwiftUI extensions. `Date.swift` is the largest (start/end of day/week/month/year, math helpers, day-name accessors). `Extensions/Date/Date+Comparison.swift` adds `isOnTheSameDay`, `isInTheSameWeek`, etc. via a generalized `isSame(as:whenComparing:)`.
- **`Views/`** — Reusable SwiftUI views (`AsyncButton`, `Ring`, `OpenGauge`, `BottomButton`, `EllipsisMenu`, `ClearButtonTextField`, etc.), plus subdirectories: `ButtonStyles/` (Aqua, Smooth, Compressible, Outlined), `ViewModifiers/` (`DragToDismiss`, `AppearanceDelay`, `SFSymbolAlignment`, etc.), `Environment/` (custom environment values like `TintColor`, `UIScreen+CornerRadius`), `VariableBlur/` (Metal-backed blur).
- **`FormatStyles/`** — Custom `FormatStyle` implementations (e.g. `RelativeDateStyle`).
- **`Previews/`** — `PreviewList` helper for organizing SwiftUI previews.

### Cross-platform conventions

- Use `#if canImport(UIKit)` / `#if canImport(AppKit)` guards for platform-specific APIs (see `UXColor.swift`, `LocalNotifications.swift`).
- Prefer the `UXColor` typealias over raw `UIColor`/`NSColor`.
- Logging uses `os.Logger` with `subsystem: "Backpack"` (or the feature name) and a `category` matching the type.

### Calendar handling

Date math defaults to `Calendar.current` (see `Extensions/Date.swift`, `Extensions/Date/Date+Comparison.swift`). A recent fix (`fe36294 Fixed hard coded gregorian calendar`) removed hard-coded `.gregorian` calendars — keep using `Calendar.current` rather than reintroducing fixed identifiers.

## Tests

XCTest-based, located in `Tests/BackpackTests/`. Each topic area has a corresponding test file (`TimeframeTests`, `DateTests`, `DateComparisonTests`, `StringTests`, `DoubleTests`, `NotificationTests`). Tests use `@testable import Backpack` and rely on the date convenience initializers from the Date extension (e.g. `Date(year: 2024, month: 6, day: 15)`).
