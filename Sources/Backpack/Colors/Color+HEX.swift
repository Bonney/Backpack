//
//  File.swift
//
//
//  Created by Matt Bonney on 7/14/22.
//

import SwiftUI

public extension Color {
    /// Initializes a `Color` from a hex string ("#RGB", "#RRGGBB", or "#AARRGGBB").
    ///
    /// On parse failure this falls back to `Color.clear` (rather than silently producing a near-transparent
    /// dark color) and trips a debug assertion so the bad input is caught during development.
    /// For caller-validated input use ``init(hex:)-failable`` to get an `Optional<Color>` instead.
    init(hex: String) {
        guard let parsed = Color.parseHex(hex) else {
            assertionFailure("Color(hex:) received unparseable input: \(hex)")
            self = .clear
            return
        }
        self = parsed
    }

    /// Failable initializer for `Color` from a hex string. Returns `nil` on parse failure.
    init?(hex: String, strict: Bool) {
        guard strict, let parsed = Color.parseHex(hex) else { return nil }
        self = parsed
    }

    private static func parseHex(_ hex: String) -> Color? {
        let trimmed = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        guard Scanner(string: trimmed).scanHexInt64(&int) else { return nil }

        let a, r, g, b: UInt64
        switch trimmed.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return nil
        }

        return Color(
            .sRGB,
            red:     Double(r) / 255,
            green:   Double(g) / 255,
            blue:    Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
