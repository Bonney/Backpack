import SwiftUI
import XCTest
@testable import Backpack

/// The palettes used to be defined as sRGB / Display P3 values (asset catalog, hex strings,
/// `Color(red:green:blue:)`). These check that their OKLCH replacements still land on the originals.
final class ColorPaletteTests: XCTestCase {
    private func assertResolves(
        _ components: ColorComponents,
        toSRGB red: Double, _ green: Double, _ blue: Double,
        accuracy: Double = 0.5 / 255,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let resolved = components.swiftUIColor.resolve(in: EnvironmentValues())
        XCTAssertEqual(Double(resolved.red), red, accuracy: accuracy, file: file, line: line)
        XCTAssertEqual(Double(resolved.green), green, accuracy: accuracy, file: file, line: line)
        XCTAssertEqual(Double(resolved.blue), blue, accuracy: accuracy, file: file, line: line)
    }

    private func assertResolves(
        _ components: ColorComponents,
        toHex hex: Int,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        assertResolves(
            components,
            toSRGB: Double(hex >> 16 & 0xFF) / 255, Double(hex >> 8 & 0xFF) / 255, Double(hex & 0xFF) / 255,
            file: file,
            line: line
        )
    }

    func testGemstones() {
        assertResolves(.ruby, toSRGB: 0.969, 0.180, 0.231)
        XCTAssertEqual(ColorComponents.gemstones.count, 9)
    }

    func testIPhone() {
        assertResolves(ColorComponents.iPhone14.red, toSRGB: 0.875, 0.035, 0.153)
        assertResolves(ColorComponents.iPhone15.blue, toSRGB: 0.953, 0.973, 0.976)
        XCTAssertEqual(ColorComponents.iPhoneColors.count, 24)
    }

    func testWatchOS() {
        assertResolves(ColorComponents.watchOS.red, toHex: 0xDF0B24)
        assertResolves(ColorComponents.watchOS.white, toHex: 0xFFFFFF)
        assertResolves(ColorComponents.watchOS.nike.volt, toHex: 0xDFFD04)
        XCTAssertEqual(LabeledColor.watchOSColors.count, 83)
    }

    func testHyper() {
        // HyperRed was Display P3 (0.976, 0.232, 0.101), which sits outside sRGB, so compare in P3.
        let p3 = Oklch(l: 0.6601, c: 0.2683, h: 31.52).p3()
        XCTAssertEqual(p3.r, 0.976, accuracy: 0.5 / 255)
        XCTAssertEqual(p3.g, 0.232, accuracy: 0.5 / 255)
        XCTAssertEqual(p3.b, 0.101, accuracy: 0.5 / 255)
        XCTAssertEqual(ColorComponents.hyper.red, ColorComponents(luminance: 0.6601, chroma: 0.2683, hue: 31.52))
        XCTAssertEqual(Color.hyperColors.count, 10)
    }

    func testLabeledColorComponents() {
        XCTAssertEqual(LabeledColor.ruby.components, .ruby)
        XCTAssertEqual(LabeledColor.watchOS_voltNike.components, ColorComponents.watchOS.nike.volt)
        XCTAssertNil(LabeledColor.systemBlue.components)
        XCTAssertTrue(LabeledColor.gemstones.allSatisfy { $0.components != nil })
        XCTAssertTrue(LabeledColor.watchOSColors.allSatisfy { $0.components != nil })
    }
}
