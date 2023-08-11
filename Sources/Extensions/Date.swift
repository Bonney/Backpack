//
//  Date++.swift
//  PhotoCal
//
//  Created by Matt Bonney on 1/5/21.
//

import SwiftUI
import Foundation

// MARK: - Math between Dates
public extension Date {
    /// Calculate the number of seconds between two Dates.
    /// - Parameters:
    ///   - startDate: Some `Date`.
    ///   - endDate: Some other `Date`.
    /// - Returns: Number of seconds between `startDate` and `endDate`.
    static func seconds(between startDate: Date, and endDate: Date) -> Int {
        let diff = abs(Int(endDate.timeIntervalSince1970 - startDate.timeIntervalSince1970))
        return diff
    }

    /// Calculate the number of hours between two Dates.
    /// - Parameters:
    ///   - startDate: Some `Date`.
    ///   - endDate: Some other `Date`.
    /// - Returns: Number of hours between `startDate` and `endDate`.
    static func hours(between startDate: Date, and endDate: Date) -> Int {
        return seconds(between: startDate, and: endDate) / 60
    }


    /// Calculate the number of seconds between this date and another.
    /// - Parameter comparisonDate: A date to compare this date object to.
    /// - Returns: The number of seconds between this date and `comparisonDate`.
    func seconds(since comparisonDate: Date) -> Int {
        return Date.seconds(between: comparisonDate, and: self)
    }
}

// MARK: Strings
public extension Date {
    var relativeDateAndTime: String {
        let formatter = DateFormatter()
        formatter.doesRelativeDateFormatting = true
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }

    var shortWeekdayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self).capitalized
    }

    var weekdayName: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }

    var monthDayYear: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }

    func monthDay(alwaysTwoDigitDay: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = alwaysTwoDigitDay ? "M/dd" : "M/d"
        return dateFormatter.string(from: self)
    }

    var hourMinuteAMPM: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self)
    }

    func humanFormatted(short: Bool = false) -> String {
        let formatter = DateFormatter()
        if short {
            formatter.dateStyle = .short
            formatter.timeStyle = .short
        } else {
            formatter.dateStyle = .long
            formatter.timeStyle = .short
        }
        let string = formatter.string(from: self)
        return ( string.replacingOccurrences(of: "12:00 AM", with: "Midnight").replacingOccurrences(of: "12:00 PM", with: "Noon") )
    }
}

// MARK: Dates
public extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.hour = 23
        components.minute = 59
        components.second = 59
        return Calendar.current.date(byAdding: components, to: self.startOfDay) ?? self
    }
}

// MARK: Bools
public extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }

    func isBefore(date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"

        guard let comparisonDate = dateFormatter.date(from: date) else {
            print("@@ ERROR WITH COMPARISON DATE")
            return false
        }

        let referenceDate = self
        return !(referenceDate.compare(comparisonDate) == ComparisonResult.orderedDescending)
    }

    func isAfter(date: String) -> Bool {
        return !(self.isBefore(date: date))
    }
}

// MARK: Ints & Doubles
public extension Calendar {
    func numberOfDaysInMonth(for date: Date) -> Int {
        return range(of: .day, in: .month, for: date)!.count
    }

    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        return numberOfDays.day ?? 0
    }
}

// MARK: Initializers
public extension Date {
    /// Initializes a date from a string
    /// - Parameters:
    ///   - string: date input
    ///   - format: format, default is "yyyy-MM-dd HH:mm:ss"
    init(string: String, format: String = "yyyy-MM-dd HH:mm:ss") {
        let df = DateFormatter()
        df.dateFormat = format
        guard let d = df.date(from: string) else { fatalError("Failed to initialize a Date object in the custom Date() extension. Matt, go fix your code.") }
        self.init(timeInterval: 0, since: d)
    }

}

public extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}

public extension TimeInterval {

    func formattedString() -> String {
        self.format(self)
    }

    func format(_ duration: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]

        if duration >= 3600 {
            formatter.allowedUnits.insert(.hour)
        }

        return formatter.string(from: duration)!
    }

    func asMinutes() -> Double { return self / (60.0) }
    func asHours()   -> Double { return self / (60.0 * 60.0) }
    func asDays()    -> Double { return self / (60.0 * 60.0 * 24.0) }
    func asWeeks()   -> Double { return self / (60.0 * 60.0 * 24.0 * 7.0) }
    func asMonths()  -> Double { return self / (60.0 * 60.0 * 24.0 * 30.4369) }
    func asYears()   -> Double { return self / (60.0 * 60.0 * 24.0 * 365.2422) }
}

public extension Date {
    var dayNumber: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }

    static var indexOfToday: Int {
        Date().day + prefix - 1
    }

    static var countOfItems: Int {
        items.count
    }

    static var prefix: Int {
        beginningOfMonth.weekday - 1
    }

//    static var monthName: String {
//        beginningOfMonth.monthName
//    }

    static var items: [String] {
        var daysInMonth = [String]()
        for day in 1 ... beginningOfMonth.daysInMonth {
            daysInMonth.append("\(day)")
        }
        return [String](repeating: "", count: prefix) + daysInMonth
    }
}

public extension Date {
    var calendar: Calendar {
        Calendar.current
    }

    var daysInMonth: Int {
        calendar.numberOfDaysInMonth(for: self)
    }

    var weekday: Int {
        return calendar.component(.weekday, from: self)
    }

    var hourInt: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .hour, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentDay = calendar.component(.hour, from: self)
            let hrsToAdd = newValue - currentDay
            if let date = calendar.date(byAdding: .hour, value: hrsToAdd, to: self) {
                self =
                date
            }
        }
    }

    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            let allowedRange = calendar.range(of: .day, in: .month, for: self)!
            guard allowedRange.contains(newValue) else { return }

            let currentDay = calendar.component(.day, from: self)
            let daysToAdd = newValue - currentDay
            if let date = calendar.date(byAdding: .day, value: daysToAdd, to: self) {
                self = date
            }
        }
    }

    func beginning(of component: Calendar.Component) -> Date? {
        if component == .day {
            return calendar.startOfDay(for: self)
        }

        var components: Set<Calendar.Component> {
            switch component {
            case .second:
                return [.year, .month, .day, .hour, .minute, .second]

            case .minute:
                return [.year, .month, .day, .hour, .minute]

            case .hour:
                return [.year, .month, .day, .hour]

            case .weekOfYear, .weekOfMonth:
                return [.yearForWeekOfYear, .weekOfYear]

            case .month:
                return [.year, .month]

            case .year:
                return [.year]

            default:
                return []
            }
        }

        guard !components.isEmpty else { return nil }
        return calendar.date(from: calendar.dateComponents(components, from: self))
    }

    mutating func add(_ component: Calendar.Component, value: Int) {
        if let date = calendar.date(byAdding: component, value: value, to: self) {
            self = date
        }
    }

    static var beginningOfTomorrow: Date {
        var date = Date().beginning(of: .day) ?? Date()
        date.add(.day, value: 1)
        return date
    }

    static var beginningOfMonth: Date {
        let date = Date()
        return date.beginning(of: .month) ?? Date()
    }
}

struct DateStringsDemo: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(Date(string: "2022-03-15 13:52:00"), format: .dateTime)
            Text(Date().weekdayName)
            Text(Date().shortWeekdayName)
//            Text(Date().monthName) + Text(" ") + Text(Date().dayNumber)
        }
    }
}

struct DateStringsDemo_Previews: PreviewProvider {
    static var previews: some View {
        DateStringsDemo()
            .previewLayout(.sizeThatFits)
    }
}


public extension Date {

    var thisSecond: Int {
        Calendar.current.component(.second, from: Date())
    }

    static var today: Date {
        Date()
    }

    static var yesterday: Date {
        guard let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else {
            fatalError("Unable to create Date 'yesterday'")
        }
        return yesterday
    }

    static var tomorrow: Date {
        guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) else {
            fatalError("Unable to create Date 'tomorrow'")
        }
        return tomorrow
    }

    static func offset(from date: Date = Date(), by days: Int) -> Date {
        guard let d = Calendar.current.date(byAdding: .day, value: days, to: date) else {
            fatalError("Unable to create Date offset \(days) days from date: \(date)")
        }
        return d
    }

    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }

    var startOfLastWeek: Date? {
        Date.offset(from: Date(), by: -7).startOfWeek
    }

    var endOfLastWeek: Date? {
        Date.offset(from: Date(), by: -7).endOfWeek
    }

    static var firstDayOfCurrentMonth: Date? {
        let components = Calendar.current.dateComponents([.year, .month], from: Date.today)
        return Calendar.current.date(from: components)
    }

}

// For appstorage
extension Date: RawRepresentable {
    public var rawValue: String {
        self.timeIntervalSinceReferenceDate.description
    }

    public init?(rawValue: String) {
        self = Date(timeIntervalSinceReferenceDate: Double(rawValue) ?? 0.0)
    }
}

public extension Date {
    var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: self)
    }

    func isInTheFuture() -> Bool {
        return self > Date.now
    }

    init(year: Int, month: Int, day: Int, hour: Int? = nil, minute: Int? = nil) {
        self.init()
        self = Calendar.current.date(from: DateComponents(year: year, month: month, day: day, hour: hour, minute: minute)) ?? Date.now
    }
}

