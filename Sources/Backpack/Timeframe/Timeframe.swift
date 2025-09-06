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
                guard let start = Date.now.startOfWeek, let end = Date.now.endOfWeek else {
                    Timeframe.logger.error("Couldn't find start/end dates for .thisWeek")
                    fatalError()
                }
                return start ... end

            case .thisMonth:
                guard let start = Date.now.startOfMonth, let end = Date.now.endOfMonth else {
                    Timeframe.logger.error("Couldn't find start/end dates for .thisMonth")
                    fatalError()
                }
                return start ... end

            case .thisYear:
                guard let start = Date.now.startOfMonth, let end = Date.now.endOfMonth else {
                    Timeframe.logger.error("Couldn't find start/end dates for .thisMonth")
                    fatalError()
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
