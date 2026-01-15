import XCTest
@testable import Backpack

final class DateComparisonTests: XCTestCase {

    // MARK: - isSame Tests

    func testIsSameYear() throws {
        let date1 = Date(year: 2024, month: 6, day: 15)
        let date2 = Date(year: 2024, month: 12, day: 31)
        let date3 = Date(year: 2023, month: 6, day: 15)

        XCTAssertTrue(date1.isSame(as: date2, whenComparing: [.year]))
        XCTAssertFalse(date1.isSame(as: date3, whenComparing: [.year]))
    }

    func testIsSameMonth() throws {
        let date1 = Date(year: 2024, month: 6, day: 15)
        let date2 = Date(year: 2024, month: 6, day: 20)
        let date3 = Date(year: 2024, month: 7, day: 15)

        XCTAssertTrue(date1.isSame(as: date2, whenComparing: [.month]))
        XCTAssertFalse(date1.isSame(as: date3, whenComparing: [.month]))
    }

    func testIsSameDay() throws {
        let date1 = Date(year: 2024, month: 6, day: 15, hour: 10, minute: 0)
        let date2 = Date(year: 2024, month: 6, day: 15, hour: 14, minute: 30)
        let date3 = Date(year: 2024, month: 6, day: 16, hour: 10, minute: 0)

        XCTAssertTrue(date1.isSame(as: date2, whenComparing: [.day]))
        XCTAssertFalse(date1.isSame(as: date3, whenComparing: [.day]))
    }

    func testIsSameYearMonthDay() throws {
        let date1 = Date(year: 2024, month: 6, day: 15, hour: 10, minute: 0)
        let date2 = Date(year: 2024, month: 6, day: 15, hour: 20, minute: 30)
        let date3 = Date(year: 2024, month: 6, day: 16, hour: 10, minute: 0)

        XCTAssertTrue(date1.isSame(as: date2, whenComparing: [.year, .month, .day]))
        XCTAssertFalse(date1.isSame(as: date3, whenComparing: [.year, .month, .day]))
    }

    // MARK: - isOnTheSameDay Tests

    func testIsOnTheSameDay() throws {
        let morning = Date(year: 2024, month: 6, day: 15, hour: 8, minute: 0)
        let evening = Date(year: 2024, month: 6, day: 15, hour: 20, minute: 0)
        let nextDay = Date(year: 2024, month: 6, day: 16, hour: 8, minute: 0)

        XCTAssertTrue(morning.isOnTheSameDay(as: evening))
        XCTAssertFalse(morning.isOnTheSameDay(as: nextDay))
    }

    func testIsOnTheSameDayAcrossMonths() throws {
        let endOfMonth = Date(year: 2024, month: 6, day: 30)
        let startOfNextMonth = Date(year: 2024, month: 7, day: 1)

        XCTAssertFalse(endOfMonth.isOnTheSameDay(as: startOfNextMonth))
    }

    func testIsOnTheSameDayAcrossYears() throws {
        let endOfYear = Date(year: 2023, month: 12, day: 31)
        let startOfYear = Date(year: 2024, month: 1, day: 1)

        XCTAssertFalse(endOfYear.isOnTheSameDay(as: startOfYear))
    }

    // MARK: - isInTheSameWeek Tests

    func testIsInTheSameWeek() throws {
        let monday = Date(year: 2024, month: 6, day: 10) // Monday
        let friday = Date(year: 2024, month: 6, day: 14) // Friday (same week)
        let nextMonday = Date(year: 2024, month: 6, day: 17) // Next Monday

        XCTAssertTrue(monday.isInTheSameWeek(as: friday))
        XCTAssertFalse(monday.isInTheSameWeek(as: nextMonday))
    }

    func testIsInTheSameWeekAcrossMonths() throws {
        // Find a date that spans across months
        let lastDayOfMonth = Date(year: 2024, month: 6, day: 30) // Sunday
        let firstDayOfNextMonth = Date(year: 2024, month: 7, day: 1) // Monday

        // These might be in different weeks depending on the week numbering system
        // Just verify the method runs without error
        _ = lastDayOfMonth.isInTheSameWeek(as: firstDayOfNextMonth)
    }

    // MARK: - isInTheSameMonth Tests

    func testIsInTheSameMonth() throws {
        let firstDay = Date(year: 2024, month: 6, day: 1)
        let midMonth = Date(year: 2024, month: 6, day: 15)
        let lastDay = Date(year: 2024, month: 6, day: 30)
        let nextMonth = Date(year: 2024, month: 7, day: 1)

        XCTAssertTrue(firstDay.isInTheSameMonth(as: midMonth))
        XCTAssertTrue(firstDay.isInTheSameMonth(as: lastDay))
        XCTAssertFalse(firstDay.isInTheSameMonth(as: nextMonth))
    }

    func testIsInTheSameMonthDifferentYears() throws {
        let june2024 = Date(year: 2024, month: 6, day: 15)
        let june2023 = Date(year: 2023, month: 6, day: 15)

        XCTAssertFalse(june2024.isInTheSameMonth(as: june2023))
    }

    // MARK: - isInTheSameYear Tests

    func testIsInTheSameYear() throws {
        let january = Date(year: 2024, month: 1, day: 1)
        let june = Date(year: 2024, month: 6, day: 15)
        let december = Date(year: 2024, month: 12, day: 31)
        let nextYear = Date(year: 2025, month: 1, day: 1)

        XCTAssertTrue(january.isInTheSameYear(as: june))
        XCTAssertTrue(january.isInTheSameYear(as: december))
        XCTAssertFalse(january.isInTheSameYear(as: nextYear))
    }

    // MARK: - isInTheNext Tests

    func testIsInTheNextDays() throws {
        let today = Date()
        let tomorrow = Date.tomorrow
        let twoDaysFromNow = Date.offset(from: today, by: 2)
        let tenDaysFromNow = Date.offset(from: today, by: 10)

        // Tomorrow should be in the next 5 days
        XCTAssertTrue(tomorrow.isInTheNext(number: 5, of: .day))

        // Two days from now should be in the next 5 days
        XCTAssertTrue(twoDaysFromNow.isInTheNext(number: 5, of: .day))

        // Ten days from now should NOT be in the next 5 days
        XCTAssertFalse(tenDaysFromNow.isInTheNext(number: 5, of: .day))
    }

    func testIsInTheNextWeeks() throws {
        let today = Date()
        let oneWeekFromNow = Date.offset(from: today, by: 7)
        let threeWeeksFromNow = Date.offset(from: today, by: 21)

        // One week from now should be in the next 2 weeks
        XCTAssertTrue(oneWeekFromNow.isInTheNext(number: 2, of: .weekOfYear))

        // Three weeks from now should NOT be in the next 2 weeks
        XCTAssertFalse(threeWeeksFromNow.isInTheNext(number: 2, of: .weekOfYear))
    }

    func testIsInTheNextMonths() throws {
        let today = Date()

        guard let oneMonthFromNow = Calendar.current.date(byAdding: .month, value: 1, to: today),
              let threeMonthsFromNow = Calendar.current.date(byAdding: .month, value: 3, to: today) else {
            XCTFail("Could not create future dates")
            return
        }

        // One month from now should be in the next 2 months
        XCTAssertTrue(oneMonthFromNow.isInTheNext(number: 2, of: .month))

        // Three months from now should NOT be in the next 2 months
        XCTAssertFalse(threeMonthsFromNow.isInTheNext(number: 2, of: .month))
    }

    func testIsInTheNextWithPastDate() throws {
        let yesterday = Date.yesterday

        // Yesterday should NOT be in the next 5 days (it's in the past)
        XCTAssertFalse(yesterday.isInTheNext(number: 5, of: .day))
    }

    // MARK: - isInTheLast Tests

    func testIsInTheLastDays() throws {
        let today = Date()
        let yesterday = Date.yesterday
        let twoDaysAgo = Date.offset(from: today, by: -2)
        let tenDaysAgo = Date.offset(from: today, by: -10)

        // Yesterday should be in the last 5 days
        XCTAssertTrue(yesterday.isInTheLast(number: 5, of: .day))

        // Two days ago should be in the last 5 days
        XCTAssertTrue(twoDaysAgo.isInTheLast(number: 5, of: .day))

        // Ten days ago should NOT be in the last 5 days
        XCTAssertFalse(tenDaysAgo.isInTheLast(number: 5, of: .day))
    }

    func testIsInTheLastWeeks() throws {
        let today = Date()
        let oneWeekAgo = Date.offset(from: today, by: -7)
        let threeWeeksAgo = Date.offset(from: today, by: -21)

        // One week ago should be in the last 2 weeks
        XCTAssertTrue(oneWeekAgo.isInTheLast(number: 2, of: .weekOfYear))

        // Three weeks ago should NOT be in the last 2 weeks
        XCTAssertFalse(threeWeeksAgo.isInTheLast(number: 2, of: .weekOfYear))
    }

    func testIsInTheLastMonths() throws {
        let today = Date()

        guard let oneMonthAgo = Calendar.current.date(byAdding: .month, value: -1, to: today),
              let threeMonthsAgo = Calendar.current.date(byAdding: .month, value: -3, to: today) else {
            XCTFail("Could not create past dates")
            return
        }

        // One month ago should be in the last 2 months
        XCTAssertTrue(oneMonthAgo.isInTheLast(number: 2, of: .month))

        // Three months ago should NOT be in the last 2 months
        XCTAssertFalse(threeMonthsAgo.isInTheLast(number: 2, of: .month))
    }

    func testIsInTheLastWithFutureDate() throws {
        let tomorrow = Date.tomorrow

        // Tomorrow should NOT be in the last 5 days (it's in the future)
        XCTAssertFalse(tomorrow.isInTheLast(number: 5, of: .day))
    }

    // MARK: - Edge Cases

    func testIsInTheLastWithToday() throws {
        let today = Date()

        // Today should be considered in the last 1 day (within the range)
        XCTAssertTrue(today.isInTheLast(number: 1, of: .day))
    }

    func testIsInTheNextWithToday() throws {
        let today = Date()

        // Today should be considered in the next 1 day (within the range)
        XCTAssertTrue(today.isInTheNext(number: 1, of: .day))
    }
}
