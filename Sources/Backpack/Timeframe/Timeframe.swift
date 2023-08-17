import Foundation

/// Represents a period of time for running HealthKit queries.
public enum Timeframe {
    /// Used when we want access to all data ever saved.
    case allTime

    /// The current day, from 12:00 AM to now.
    case today

    /// From the beginning of this week to date.
    case weekToDate

    /// From the first of this month to date.
    case monthToDate

    /// From Jan. 1 of this year to date.
    case yearToDate

    /// Query for the last X days, weeks, or months.
    case pastDays(_ count: Int)
    case pastWeeks(_ count: Int)
    case pastMonths(_ count: Int)

    /// Query for a specific date range.
    case range(startDate: Date, endDate: Date)

    /// Returns the start and end dates for the query.
    public var dates: (start: Date?, end: Date?) {
        switch self {
            case .allTime:
                return (nil, nil)

            case .today:
                return (Calendar.current.startOfDay(for: .now), .now)

            case .weekToDate:
                let components = Calendar.current.dateComponents([.weekOfYear], from: Date.now)
                let startOfWeek = Calendar.current.date(from: components) ?? Date.now
                return (startOfWeek, .now)

            case .monthToDate:
                let components = Calendar.current.dateComponents([.month], from: Date.now)
                let startOfMonth = Calendar.current.date(from: components) ?? Date.now
                return (startOfMonth, .now)

            case .yearToDate:
                let components = Calendar.current.dateComponents([.year], from: Date.now)
                let startOfYear = Calendar.current.date(from: components) ?? Date.now
                return (startOfYear, .now)

            case .pastDays(let count):
                let start = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: (-1 * count) + 1, to: Date.now) ?? .now)
                return (start, .now)

            case .pastWeeks(let count):
                let start = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: -7 * count, to: Date.now) ?? .now)
                return (start, .now)

            case .pastMonths(let count):
                let start = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .month, value: -1 * count, to: Date.now) ?? .now)
                return (start, .now)

            case .range(startDate: let startDate, endDate: let endDate):
                return (startDate, endDate)
        }
    }
}

extension Timeframe: Hashable { }

extension Timeframe: Identifiable {
    public var id: String {
        switch self {
            case .allTime:
                return "allTime"
            case .today:
                return "today"
            case .weekToDate:
                return "weekToDate"
            case .monthToDate:
                return "monthToDate"
            case .yearToDate:
                return "yearToDate"
            case .pastDays(_):
                return "pastDays"
            case .pastWeeks(_):
                return "pastWeeks"
            case .pastMonths(_):
                return "pastMonths"
            case .range(_, _):
                return "range"
        }
    }
}
