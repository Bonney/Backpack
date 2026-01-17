import os
import Foundation

/// Represents a period of time for running HealthKit queries.
public enum Timeframe {
    private static let logger = Logger(subsystem: "Backpack", category: "Timeframe")

    /// Used when we want access to all data ever saved.
    case allTime

    /// The current day, from 12:00 AM to now.
    case today

    /// This calendar week.
    case thisWeek

    /// This calendar month.
    case thisMonth

    /// This calendar year.
    case thisYear

    /// Query for a specific date range.
    case from(start: Date, end: Date)

    /// Allow initializing a `.from(start:end:)` timeframe from a `Date`.
    public static func date(_ date: Date) -> Timeframe {
        return .from(start: date.startOfDay, end: date.endOfDay)
    }
}

extension Timeframe {
    public var dateRange: ClosedRange<Date> {
        switch self {
            case .allTime:
                return Date(timeIntervalSince1970: 0) ... Date.now.endOfDay

            case .today:
                return Date.now.startOfDay ... Date.now.endOfDay

            case .thisWeek:
                let start = Date.now.startOfWeek ?? Date.now.startOfDay
                let end = Date.now.endOfWeek ?? Date.now.endOfDay
                if start == Date.now.startOfDay || end == Date.now.endOfDay {
                    Timeframe.logger.warning("Using fallback dates for .thisWeek")
                }
                return start ... end

            case .thisMonth:
                let start = Date.now.startOfMonth ?? Date.now.startOfDay
                let end = Date.now.endOfMonth ?? Date.now.endOfDay
                if start == Date.now.startOfDay || end == Date.now.endOfDay {
                    Timeframe.logger.warning("Using fallback dates for .thisMonth")
                }
                return start ... end

            case .thisYear:
                let start = Date.now.startOfYear ?? Date.now.startOfDay
                let end = Date.now.endOfYear ?? Date.now.endOfDay
                if start == Date.now.startOfDay || end == Date.now.endOfDay {
                    Timeframe.logger.warning("Using fallback dates for .thisYear")
                }
                return start ... end

            case .from(let start, let end):
                return start ... end
        }
    }
}

extension Timeframe: Sendable { }

extension Timeframe: Hashable { }

extension Timeframe: Identifiable {
    public var id: String {
        self.description
    }
}

extension Timeframe: CustomStringConvertible {
    public var description: String {
        switch self {
            case .allTime:
                return "All Time"
            case .today:
                return "Today"
            case .thisWeek:
                return "This Week"
            case .thisMonth:
                return "This Month"
            case .thisYear:
                return "This Year"
            case .from(let start, let end):
                return "\(start.formatted(date: .numeric, time: .omitted)) – \(end.formatted(date: .numeric, time: .omitted))"
        }
    }
}
