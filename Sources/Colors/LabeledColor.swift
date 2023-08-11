//
//  File.swift
//  
//
//  Created by Matt Bonney on 7/14/22.
//

import SwiftUI

/// A SwiftUI Color, annotated with a display name String.
///
/// - Parameters:
///     - name: the display name for the color
///     - color: a SwiftUI Color
///
public struct LabeledColor: Identifiable, Hashable {
    public let id: UUID
    public let name: String
    public let color: Color
    public var contrastingForegroundColor: Color {
        self.color.contrastingForegroundColor
    }

    /// A SwiftUI Label, where the Title is this LabeledColor's Name,
    /// and the Icon is a circle in this LabeledColor's Color.
    @ViewBuilder public var label: some View {
        Label {
            Text(name.capitalized)
        } icon: {
            Image(systemName: "circle")
                .symbolVariant(.fill)
                .foregroundStyle(color)
        }
    }

    public init(_ name: String, color: Color) {
        self.id = UUID()
        self.name = name
        self.color = color
    }
}

public extension LabeledColor {
    init(_ name: String, hex: String) {
        self.init(name, color: Color(hex: hex))
    }
}

public extension LabeledColor {
    static let systemBlue = LabeledColor("Blue", color: Color.blue)
    static let systemGreen = LabeledColor("Green", color: Color.green)
    static let systemTeal = LabeledColor("Teal", color: Color.teal)
    static let systemCyan = LabeledColor("Cyan", color: Color.cyan)
    static let systemMint = LabeledColor("Mint", color: Color.mint)
    static let systemIndigo = LabeledColor("Indigo", color: Color.indigo)
    static let systemPurple = LabeledColor("Purple", color: Color.purple)
    static let systemRed = LabeledColor("Red", color: Color.red)
    static let systemOrange = LabeledColor("Orange", color: Color.orange)
    static let systemYellow = LabeledColor("Yellow", color: Color.yellow)

    static var systemColors: [LabeledColor] {
        [LabeledColor.systemBlue, .systemGreen, .systemTeal, .systemCyan, .systemMint, .systemIndigo, .systemPurple, .systemOrange, .systemYellow]
    }
}

public enum LabeledColorSet: CaseIterable {
    case systemColors
    case gemstoneColors
    case watchOSColors

    public var colors: [LabeledColor] {
        switch self {
            case .systemColors:
                return LabeledColor.systemColors
            case .gemstoneColors:
                return LabeledColor.gemstones
            case .watchOSColors:
                return LabeledColor.watchOSColors
        }
    }

    public static var allColorSets: [LabeledColor] {
        LabeledColorSet.allCases.map { $0.colors }.reduce([], +)
    }
}

