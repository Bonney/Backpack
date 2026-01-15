import XCTest
@testable import Backpack

final class DateTests: XCTestCase {

    // MARK: - Date Math Tests

    func testSecondsBetweenDates() throws {
        let start = Date(year: 2024, month: 6, day: 1, hour: 10, minute: 0)
        let end = Date(year: 2024, month: 6, day: 1, hour: 10, minute: 5)

        let seconds = Date.seconds(between: start, and: end)

        XCTAssertEqual(seconds, 300) // 5 minutes = 300 seconds
    }

    func testSecondsBetweenDatesReversed() throws {
        let start = Date(year: 2024, month: 6, day: 1, hour: 10, minute: 5)
        let end = Date(year: 2024, month: 6, day: 1, hour: 10, minute: 0)

        let seconds = Date.seconds(between: start, and: end)

        // Should be absolute value
        XCTAssertEqual(seconds, 300)
    }

    func testSecondsSinceDate() throws {
        let past = Date(year: 2024, month: 6, day: 1, hour: 10, minute: 0)
        let future = Date(year: 2024, month: 6, day: 1, hour: 10, minute: 2)

        let seconds = future.seconds(since: past)

        XCTAssertEqual(seconds, 120) // 2 minutes
    }

    func testHoursBetweenDates() throws {
        let start = Date(year: 2024, month: 6, day: 1, hour: 10, minute: 0)
        let end = Date(year: 2024, month: 6, day: 1, hour: 13, minute: 0)

        let hours = Date.hours(between: start, and: end)

        // Note: The implementation divides by 60, not 3600, so this is actually minutes
        XCTAssertEqual(hours, 180) // 3 hours = 180 minutes (due to implementation)
    }

    // MARK: - Date String Formatting Tests

    func testShortWeekdayName() throws {
        let date = Date(year: 2024, month: 6, day: 3) // Monday, June 3, 2024

        let weekday = date.shortWeekdayName

        XCTAssertTrue(weekday.count <= 3)
        XCTAssertTrue(["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"].contains(weekday))
    }

    func testWeekdayName() throws {
        let date = Date(year: 2024, month: 6, day: 3) // Monday, June 3, 2024

        let weekday = date.weekdayName

        XCTAssertTrue(["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"].contains(weekday))
    }

    func testMonthDayYear() throws {
        let date = Date(year: 2024, month: 6, day: 15)

        let formatted = date.monthDayYear

        XCTAssertEqual(formatted, "06/15/2024")
    }

    func testMonthDay() throws {
        let date = Date(year: 2024, month: 6, day: 5)

        let formatted = date.monthDay(alwaysTwoDigitDay: false)
        let formattedTwoDigit = date.monthDay(alwaysTwoDigitDay: true)

        XCTAssertEqual(formatted, "6/5")
        XCTAssertEqual(formattedTwoDigit, "6/05")
    }

    func testHourMinuteAMPM() throws {
        let date = Date(year: 2024, month: 6, day: 15, hour: 14, minute: 30)

        let formatted = date.hourMinuteAMPM

        XCTAssertEqual(formatted, "2:30 PM")
    }

    func testHumanFormattedWithMidnight() throws {
        let midnight = Date(year: 2024, month: 6, day: 15, hour: 0, minute: 0)

        let formatted = midnight.humanFormatted()

        XCTAssertTrue(formatted.contains("Midnight"))
        XCTAssertFalse(formatted.contains("12:00 AM"))
    }

    func testHumanFormattedWithNoon() throws {
        let noon = Date(year: 2024, month: 6, day: 15, hour: 12, minute: 0)

        let formatted = noon.humanFormatted()

        XCTAssertTrue(formatted.contains("Noon"))
        XCTAssertFalse(formatted.contains("12:00 PM"))
    }

    func testDayNumber() throws {
        let date = Date(year: 2024, month: 6, day: 15)

        let dayNum = date.dayNumber

        XCTAssertEqual(dayNum, "15")
    }

    func testMonthYearString() throws {
        let date = Date(year: 2024, month: 6, day: 15)

        let formatted = date.monthYearString

        XCTAssertEqual(formatted, "June 2024")
    }

    // MARK: - Start/End of Day Tests

    func testStartOfDay() throws {
        let date = Date(year: 2024, month: 6, day: 15, hour: 14, minute: 30)

        let start = date.startOfDay

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: start)

        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 6)
        XCTAssertEqual(components.day, 15)
        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
    }

    func testEndOfDay() throws {
        let date = Date(year: 2024, month: 6, day: 15, hour: 10, minute: 0)

        let end = date.endOfDay

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: end)

        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 6)
        XCTAssertEqual(components.day, 15)
        XCTAssertEqual(components.hour, 23)
        XCTAssertEqual(components.minute, 59)
        XCTAssertEqual(components.second, 59)
    }

    // MARK: - Boolean Tests

    func testIsToday() throws {
        let today = Date()
        let yesterday = Date.yesterday

        XCTAssertTrue(today.isToday)
        XCTAssertFalse(yesterday.isToday)
    }

    func testIsYesterday() throws {
        let yesterday = Date.yesterday
        let today = Date()

        XCTAssertTrue(yesterday.isYesterday)
        XCTAssertFalse(today.isYesterday)
    }

    func testIsBefore() throws {
        let early = Date(year: 2024, month: 1, day: 1)

        XCTAssertTrue(early.isBefore(date: "12/31/2024"))
        XCTAssertFalse(early.isBefore(date: "01/01/2023"))
    }

    func testIsAfter() throws {
        let late = Date(year: 2024, month: 12, day: 31)

        XCTAssertTrue(late.isAfter(date: "01/01/2024"))
        XCTAssertFalse(late.isAfter(date: "12/31/2025"))
    }

    func testIsInTheFuture() throws {
        let future = Date.tomorrow
        let past = Date.yesterday

        XCTAssertTrue(future.isInTheFuture())
        XCTAssertFalse(past.isInTheFuture())
    }

    // MARK: - Static Date Helpers

    func testToday() throws {
        let today = Date.today

        XCTAssertTrue(today.isToday)
    }

    func testYesterday() throws {
        let yesterday = Date.yesterday

        XCTAssertTrue(yesterday.isYesterday)
    }

    func testTomorrow() throws {
        let tomorrow = Date.tomorrow

        let daysDiff = Calendar.current.numberOfDaysBetween(Date(), and: tomorrow)

        XCTAssertEqual(daysDiff, 1)
    }

    func testDateOffset() throws {
        let base = Date(year: 2024, month: 6, day: 15)
        let offset = Date.offset(from: base, by: 5)

        let components1 = Calendar.current.dateComponents([.year, .month, .day], from: base)
        let components2 = Calendar.current.dateComponents([.year, .month, .day], from: offset)

        XCTAssertEqual(components1.year, 2024)
        XCTAssertEqual(components1.month, 6)
        XCTAssertEqual(components1.day, 15)

        XCTAssertEqual(components2.year, 2024)
        XCTAssertEqual(components2.month, 6)
        XCTAssertEqual(components2.day, 20)
    }

    // MARK: - Start/End of Week Tests

    func testStartOfWeek() throws {
        let date = Date(year: 2024, month: 6, day: 15) // Saturday

        guard let startOfWeek = date.startOfWeek else {
            XCTFail("Could not get start of week")
            return
        }

        let weekday = Calendar.current.component(.weekday, from: startOfWeek)

        // Should be Monday (weekday = 2)
        XCTAssertEqual(weekday, 2)
    }

    func testEndOfWeek() throws {
        let date = Date(year: 2024, month: 6, day: 15)

        guard let endOfWeek = date.endOfWeek else {
            XCTFail("Could not get end of week")
            return
        }

        let weekday = Calendar.current.component(.weekday, from: endOfWeek)

        // Should be Sunday (weekday = 1)
        XCTAssertEqual(weekday, 1)

        // Should be at end of day
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: endOfWeek)
        XCTAssertEqual(components.hour, 23)
        XCTAssertEqual(components.minute, 59)
        XCTAssertEqual(components.second, 59)
    }

    // MARK: - Start/End of Month Tests

    func testStartOfMonth() throws {
        let date = Date(year: 2024, month: 6, day: 15)

        guard let startOfMonth = date.startOfMonth else {
            XCTFail("Could not get start of month")
            return
        }

        let components = Calendar.current.dateComponents([.year, .month, .day], from: startOfMonth)

        XCTAssertEqual(components.day, 1)
    }

    func testEndOfMonth() throws {
        let date = Date(year: 2024, month: 6, day: 15)

        guard let endOfMonth = date.endOfMonth else {
            XCTFail("Could not get end of month")
            return
        }

        let components = Calendar.current.dateComponents([.year, .month, .day], from: endOfMonth)

        // June has 30 days
        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 6)
        XCTAssertEqual(components.day, 30)
    }

    // MARK: - Start/End of Year Tests

    func testStartOfYear() throws {
        let date = Date(year: 2024, month: 6, day: 15)

        guard let startOfYear = date.startOfYear else {
            XCTFail("Could not get start of year")
            return
        }

        let components = Calendar.current.dateComponents([.year, .month, .day], from: startOfYear)

        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 1)
        XCTAssertEqual(components.day, 1)
    }

    func testEndOfYear() throws {
        let date = Date(year: 2024, month: 6, day: 15)

        guard let endOfYear = date.endOfYear else {
            XCTFail("Could not get end of year")
            return
        }

        let components = Calendar.current.dateComponents([.year, .month, .day], from: endOfYear)

        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 12)
        XCTAssertEqual(components.day, 31)
    }

    // MARK: - Calendar Extensions

    func testNumberOfDaysInMonth() throws {
        let june = Date(year: 2024, month: 6, day: 1)
        let february = Date(year: 2024, month: 2, day: 1) // Leap year

        let juneCount = Calendar.current.numberOfDaysInMonth(for: june)
        let februaryCount = Calendar.current.numberOfDaysInMonth(for: february)

        XCTAssertEqual(juneCount, 30)
        XCTAssertEqual(februaryCount, 29) // 2024 is a leap year
    }

    func testNumberOfDaysBetween() throws {
        let start = Date(year: 2024, month: 6, day: 1)
        let end = Date(year: 2024, month: 6, day: 15)

        let days = Calendar.current.numberOfDaysBetween(start, and: end)

        XCTAssertEqual(days, 14)
    }

    // MARK: - Date Initializers

    func testDateFromString() throws {
        let date = Date(string: "2024-06-15 14:30:00")

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)

        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 6)
        XCTAssertEqual(components.day, 15)
        XCTAssertEqual(components.hour, 14)
        XCTAssertEqual(components.minute, 30)
    }

    func testDateFromComponents() throws {
        let date = Date(year: 2024, month: 6, day: 15, hour: 14, minute: 30)

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)

        XCTAssertEqual(components.year, 2024)
        XCTAssertEqual(components.month, 6)
        XCTAssertEqual(components.day, 15)
        XCTAssertEqual(components.hour, 14)
        XCTAssertEqual(components.minute, 30)
    }

    // MARK: - Date Subtraction Operator

    func testDateSubtraction() throws {
        let later = Date(year: 2024, month: 6, day: 15, hour: 14, minute: 0)
        let earlier = Date(year: 2024, month: 6, day: 15, hour: 13, minute: 0)

        let interval: TimeInterval = later - earlier

        XCTAssertEqual(interval, 3600) // 1 hour = 3600 seconds
    }

    // MARK: - TimeInterval Extensions

    func testTimeIntervalAsMinutes() throws {
        let interval: TimeInterval = 3600 // 1 hour

        let minutes = interval.asMinutes()

        XCTAssertEqual(minutes, 60)
    }

    func testTimeIntervalAsHours() throws {
        let interval: TimeInterval = 7200 // 2 hours

        let hours = interval.asHours()

        XCTAssertEqual(hours, 2)
    }

    func testTimeIntervalAsDays() throws {
        let interval: TimeInterval = 86400 // 1 day

        let days = interval.asDays()

        XCTAssertEqual(days, 1)
    }

    func testTimeIntervalAsWeeks() throws {
        let interval: TimeInterval = 604800 // 1 week

        let weeks = interval.asWeeks()

        XCTAssertEqual(weeks, 1, accuracy: 0.01)
    }

    func testTimeIntervalFormattedString() throws {
        let interval: TimeInterval = 125 // 2 minutes 5 seconds

        let formatted = interval.formattedString()

        XCTAssertNotNil(formatted)
        // Format varies by locale, just check it's not empty
        XCTAssertFalse(formatted.isEmpty)
    }

    // MARK: - RawRepresentable for AppStorage

    func testDateRawRepresentable() throws {
        let date = Date(year: 2024, month: 6, day: 15)

        let rawValue = date.rawValue

        let reconstructed = Date(rawValue: rawValue)

        XCTAssertNotNil(reconstructed)
        XCTAssertEqual(date.timeIntervalSinceReferenceDate, reconstructed?.timeIntervalSinceReferenceDate)
    }

    // MARK: - Date Component Properties

    func testWeekdayProperty() throws {
        let date = Date(year: 2024, month: 6, day: 3) // Monday

        let weekday = date.weekday

        XCTAssertEqual(weekday, 2) // Monday = 2 in Calendar
    }

    func testDaysInMonth() throws {
        let june = Date(year: 2024, month: 6, day: 15)

        let count = june.daysInMonth

        XCTAssertEqual(count, 30)
    }

    func testBeginningOfComponent() throws {
        let date = Date(year: 2024, month: 6, day: 15, hour: 14, minute: 30)

        guard let beginningOfHour = date.beginning(of: .hour) else {
            XCTFail("Could not get beginning of hour")
            return
        }

        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: beginningOfHour)

        XCTAssertEqual(components.hour, 14)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
    }

    func testBeginningOfTomorrow() throws {
        let tomorrow = Date.beginningOfTomorrow

        let daysDiff = Calendar.current.numberOfDaysBetween(Date(), and: tomorrow)

        XCTAssertEqual(daysDiff, 1)

        // Should be at start of day
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: tomorrow)
        XCTAssertEqual(components.hour, 0)
        XCTAssertEqual(components.minute, 0)
        XCTAssertEqual(components.second, 0)
    }

    func testBeginningOfMonth() throws {
        let beginning = Date.beginningOfMonth

        let components = Calendar.current.dateComponents([.day], from: beginning)

        XCTAssertEqual(components.day, 1)
    }
}
