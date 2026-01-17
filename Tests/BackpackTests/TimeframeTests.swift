import XCTest
@testable import Backpack

final class TimeframeTests: XCTestCase {

    // MARK: - Timeframe.date() Initializer Tests

    func testTimeframeFromDate() throws {
        let testDate = Date(year: 2024, month: 6, day: 15)
        let timeframe = Timeframe.date(testDate)

        let range = timeframe.dateRange

        // Verify it returns a range from start of day to end of day
        XCTAssertEqual(range.lowerBound, testDate.startOfDay)
        XCTAssertEqual(range.upperBound, testDate.endOfDay)
    }

    // MARK: - Timeframe.dateRange Tests

    func testAllTimeDateRange() throws {
        let timeframe = Timeframe.allTime
        let range = timeframe.dateRange

        // allTime should start from Unix epoch
        XCTAssertEqual(range.lowerBound, Date(timeIntervalSince1970: 0))

        // Should end at end of current day
        let now = Date.now
        XCTAssertTrue(range.upperBound >= now)
        XCTAssertEqual(range.upperBound.startOfDay, now.startOfDay)
    }

    func testTodayDateRange() throws {
        let timeframe = Timeframe.today
        let range = timeframe.dateRange

        let now = Date.now

        // Should be from start of today to end of today
        XCTAssertEqual(range.lowerBound, now.startOfDay)
        XCTAssertEqual(range.upperBound, now.endOfDay)
    }

    func testThisWeekDateRange() throws {
        let timeframe = Timeframe.thisWeek
        let range = timeframe.dateRange

        let now = Date.now

        // Should match start/end of current week
        XCTAssertEqual(range.lowerBound, now.startOfWeek)
        XCTAssertEqual(range.upperBound, now.endOfWeek)
    }

    func testThisMonthDateRange() throws {
        let timeframe = Timeframe.thisMonth
        let range = timeframe.dateRange

        let now = Date.now

        // Should match start/end of current month
        XCTAssertEqual(range.lowerBound, now.startOfMonth)
        XCTAssertEqual(range.upperBound, now.endOfMonth)
    }

    func testCustomFromDateRange() throws {
        let start = Date(year: 2024, month: 1, day: 1)
        let end = Date(year: 2024, month: 12, day: 31)

        let timeframe = Timeframe.from(start: start, end: end)
        let range = timeframe.dateRange

        XCTAssertEqual(range.lowerBound, start)
        XCTAssertEqual(range.upperBound, end)
    }

    // MARK: - CustomStringConvertible Tests

    func testTimeframeDescriptions() throws {
        XCTAssertEqual(Timeframe.allTime.description, "All Time")
        XCTAssertEqual(Timeframe.today.description, "Today")
        XCTAssertEqual(Timeframe.thisWeek.description, "This Week")
        XCTAssertEqual(Timeframe.thisMonth.description, "This Month")
        XCTAssertEqual(Timeframe.thisYear.description, "This Year")
    }

    func testCustomTimeframeDescription() throws {
        let start = Date(year: 2024, month: 6, day: 1)
        let end = Date(year: 2024, month: 6, day: 30)

        let timeframe = Timeframe.from(start: start, end: end)
        let description = timeframe.description

        // Should contain formatted date strings
        XCTAssertTrue(description.contains("2024"))
        XCTAssertTrue(description.contains("–") || description.contains("-"))
    }

    // MARK: - Identifiable Tests

    func testTimeframeIdentifiable() throws {
        let timeframe = Timeframe.today

        // ID should equal description
        XCTAssertEqual(timeframe.id, timeframe.description)
        XCTAssertEqual(timeframe.id, "Today")
    }

    // MARK: - Hashable Tests

    func testTimeframeHashable() throws {
        let timeframe1 = Timeframe.today
        let timeframe2 = Timeframe.today
        let timeframe3 = Timeframe.thisWeek

        XCTAssertEqual(timeframe1, timeframe2)
        XCTAssertNotEqual(timeframe1, timeframe3)

        // Test in Set
        let set: Set<Timeframe> = [timeframe1, timeframe2, timeframe3]
        XCTAssertEqual(set.count, 2) // today appears twice but should only be counted once
    }

    func testCustomTimeframeHashable() throws {
        let start = Date(year: 2024, month: 6, day: 1)
        let end = Date(year: 2024, month: 6, day: 30)

        let timeframe1 = Timeframe.from(start: start, end: end)
        let timeframe2 = Timeframe.from(start: start, end: end)

        XCTAssertEqual(timeframe1, timeframe2)
    }

    // MARK: - Sendable Tests

    func testTimeframeIsSendable() throws {
        // This test just verifies that Timeframe conforms to Sendable
        // If it compiles, the test passes
        let timeframe: any Sendable = Timeframe.today
        XCTAssertNotNil(timeframe)
    }
}
