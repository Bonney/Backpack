import XCTest
@testable import Backpack

final class DoubleTests: XCTestCase {

    // MARK: - Radians Conversion Tests

    func testToRadians() throws {
        let degrees: Double = 180
        let radians = degrees.toRadians()

        XCTAssertEqual(radians, Double.pi, accuracy: 0.0001)
    }

    func testToRadiansZero() throws {
        let degrees: Double = 0
        let radians = degrees.toRadians()

        XCTAssertEqual(radians, 0, accuracy: 0.0001)
    }

    func testToRadians90Degrees() throws {
        let degrees: Double = 90
        let radians = degrees.toRadians()

        XCTAssertEqual(radians, Double.pi / 2, accuracy: 0.0001)
    }

    func testToRadians360Degrees() throws {
        let degrees: Double = 360
        let radians = degrees.toRadians()

        XCTAssertEqual(radians, 2 * Double.pi, accuracy: 0.0001)
    }

    // MARK: - CGFloat Conversion Tests

    func testToCGFloat() throws {
        let double: Double = 42.5
        let cgFloat = double.toCGFloat()

        XCTAssertEqual(cgFloat, CGFloat(42.5))
    }

    func testToCGFloatNegative() throws {
        let double: Double = -10.25
        let cgFloat = double.toCGFloat()

        XCTAssertEqual(cgFloat, CGFloat(-10.25))
    }

    // MARK: - Double Rounding Tests

    func testDoubleRoundedToPlaces() throws {
        let value: Double = 3.14159
        let rounded = value.rounded(to: 2)

        XCTAssertEqual(rounded, 3.14, accuracy: 0.001)
    }

    func testDoubleRoundedToZeroPlaces() throws {
        let value: Double = 3.7
        let rounded = value.rounded(to: 0)

        XCTAssertEqual(rounded, 4.0, accuracy: 0.001)
    }

    func testDoubleRoundedToFourPlaces() throws {
        let value: Double = 2.718281828
        let rounded = value.rounded(to: 4)

        XCTAssertEqual(rounded, 2.7183, accuracy: 0.00001)
    }

    func testDoubleRoundedNegativeNumber() throws {
        let value: Double = -3.14159
        let rounded = value.rounded(to: 2)

        XCTAssertEqual(rounded, -3.14, accuracy: 0.001)
    }

    // MARK: - CGFloat Rounding Tests

    func testCGFloatRoundedToPlaces() throws {
        let value: CGFloat = 3.14159
        let rounded = value.rounded(to: 2)

        XCTAssertEqual(rounded, 3.14, accuracy: 0.001)
    }

    func testCGFloatRoundedToThreePlaces() throws {
        let value: CGFloat = 1.23456
        let rounded = value.rounded(to: 3)

        XCTAssertEqual(rounded, 1.235, accuracy: 0.0001)
    }

    // MARK: - Trimmed String Tests

    func testDoubleTrimmedWholeNumber() throws {
        let value: Double = 5.0
        let trimmed = value.trimmed

        XCTAssertEqual(trimmed, "5")
    }

    func testDoubleTrimmedDecimal() throws {
        let value: Double = 5.5
        let trimmed = value.trimmed

        XCTAssertEqual(trimmed, "5.5")
    }

    func testDoubleTrimmedWithTrailingZeros() throws {
        let value: Double = 5.0
        let trimmed = value.trimmed

        // Should remove trailing zeros and decimal point
        XCTAssertFalse(trimmed.contains("."))
        XCTAssertEqual(trimmed, "5")
    }

    func testCGFloatTrimmedWholeNumber() throws {
        let value: CGFloat = 10.0
        let trimmed = value.trimmed

        XCTAssertEqual(trimmed, "10")
    }

    func testCGFloatTrimmedDecimal() throws {
        let value: CGFloat = 10.75
        let trimmed = value.trimmed

        XCTAssertEqual(trimmed, "10.75")
    }

    // MARK: - Formatted Decimal String Tests

    func testFormattedDecimalStringTwoPlaces() throws {
        let value: Double = 3.14159
        let formatted = value.formattedDecimalString(places: 2)

        XCTAssertEqual(formatted, "3.14")
    }

    func testFormattedDecimalStringRemovesTrailingZeros() throws {
        let value: Double = 5.0
        let formatted = value.formattedDecimalString(places: 2)

        // Should remove trailing zeros
        XCTAssertEqual(formatted, "5")
    }

    func testFormattedDecimalStringThreePlaces() throws {
        let value: Double = 2.718281828
        let formatted = value.formattedDecimalString(places: 3)

        XCTAssertEqual(formatted, "2.718")
    }

    // MARK: - Remove Trailing Zeroes Tests

    func testRemoveTrailingZeroesWholeNumber() throws {
        let value: Double = 42.0
        let result = value.removeTrailingZeroes()

        XCTAssertEqual(result, "42")
    }

    func testRemoveTrailingZeroesDecimal() throws {
        let value: Double = 42.5
        let result = value.removeTrailingZeroes()

        XCTAssertEqual(result, "42.5")
    }

    func testRemoveTrailingZeroesLongDecimal() throws {
        let value: Double = 3.14159
        let result = value.removeTrailingZeroes()

        XCTAssertTrue(result.hasPrefix("3.14"))
    }

    // MARK: - Remove Zeros From End Tests

    func testRemoveZerosFromEndDefaultLeaving() throws {
        let value: Double = 5.0
        let result = value.removeZerosFromEnd()

        XCTAssertEqual(result, "5")
    }

    func testRemoveZerosFromEndLeavingOne() throws {
        let value: Double = 3.14159
        let result = value.removeZerosFromEnd(leaving: 1)

        // Should have at most 1 decimal place
        let components = result.split(separator: ".")
        if components.count > 1 {
            XCTAssertLessThanOrEqual(components[1].count, 1)
        }
    }

    func testRemoveZerosFromEndLeavingTwo() throws {
        let value: Double = 3.14159
        let result = value.removeZerosFromEnd(leaving: 2)

        // Should have at most 2 decimal places
        let components = result.split(separator: ".")
        if components.count > 1 {
            XCTAssertLessThanOrEqual(components[1].count, 2)
        }
    }

    func testRemoveZerosFromEndLeavingZero() throws {
        let value: Double = 5.5
        let result = value.removeZerosFromEnd(leaving: 0)

        // Should be rounded to integer
        XCTAssertEqual(result, "6")
    }

    func testRemoveZerosFromEndWholeNumber() throws {
        let value: Double = 10.0
        let result = value.removeZerosFromEnd(leaving: 2)

        // Whole numbers should not have decimal places
        XCTAssertEqual(result, "10")
    }

    func testRemoveZerosFromEndVerySmallNumber() throws {
        let value: Double = 0.001
        let result = value.removeZerosFromEnd(leaving: 3)

        // Should preserve significant digits
        XCTAssertNotEqual(result, "0")
    }

    // MARK: - Edge Cases

    func testZeroValue() throws {
        let value: Double = 0.0

        XCTAssertEqual(value.trimmed, "0")
        XCTAssertEqual(value.removeTrailingZeroes(), "0")
        XCTAssertEqual(value.removeZerosFromEnd(), "0")
    }

    func testNegativeValues() throws {
        let value: Double = -3.14

        let trimmed = value.trimmed
        let rounded = value.rounded(to: 1)

        XCTAssertTrue(trimmed.hasPrefix("-"))
        XCTAssertEqual(rounded, -3.1, accuracy: 0.01)
    }

    func testVeryLargeNumber() throws {
        let value: Double = 1_000_000.5
        let trimmed = value.trimmed

        XCTAssertTrue(trimmed.contains("1000000"))
    }

    func testVerySmallNumber() throws {
        let value: Double = 0.0001
        let rounded = value.rounded(to: 4)

        XCTAssertEqual(rounded, 0.0001, accuracy: 0.00001)
    }

    // MARK: - Precision Tests

    func testRoundingConsistency() throws {
        let value: Double = 1.005
        let rounded = value.rounded(to: 2)

        // Check rounding behavior (banker's rounding or traditional)
        XCTAssertTrue(rounded == 1.0 || rounded == 1.01)
    }

    func testFormattedDecimalStringConsistency() throws {
        let value: Double = 3.14159
        let formatted1 = value.formattedDecimalString(places: 2)
        let formatted2 = value.formattedDecimalString(places: 2)

        // Should be consistent
        XCTAssertEqual(formatted1, formatted2)
    }
}
