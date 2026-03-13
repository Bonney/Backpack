//
//  File.swift
//  OklchColorPicker
//
//  Created by Matt Bonney on 3/13/26.
//

import SwiftUI
import Foundation

public struct OKLCHColorPickerComponent: OptionSet, Equatable, Hashable, Codable, Sendable {
    public let rawValue: Int

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public static let luminance = OKLCHColorPickerComponent(rawValue: 1 << 0)
    public static let chroma = OKLCHColorPickerComponent(rawValue: 1 << 1)
    public static let hue = OKLCHColorPickerComponent(rawValue: 1 << 2)

    public static let all: OKLCHColorPickerComponent = [.luminance, .chroma, .hue]
}
