import Foundation

// MARK: - Extensions for SwiftCharts

extension Timeframe {

    public static var defaultChartTimeframes: [Timeframe] {
        [.today, .thisWeek, .thisMonth, .thisYear]
    }

    /// What date component is best used to subdivide the
    /// x-axis for a given Timeframe.
    public var chartXAxisStrideCalendarComponent: Calendar.Component {
        switch self {
            case .allTime:
                return .era
            case .today:
                return .hour // Show a bar for each hour of a 24 hour day
            case .thisWeek:
                return .day // Show a bar for each day for far this week
            case .thisMonth:
                return .day // Show a bar for each day so far this month
            case .thisYear:
                return .month // Show a bar for each of the 12 months
            case .from(_, _):
                return .day
        }
    }

    /// The number of x-axis columns to use for a given Timeframe.
    public var chartXAxisSubdivisions: Int {
        switch self {
            case .allTime:
                return 1
            case .today:
                return 24 // 24 hours in a day.
            case .thisWeek:
                return 7 // 7 days in a week
            case .thisMonth:
                return Date.now.daysInMonth // 28/29, 30, or 31 days per month
            case .thisYear:
                return 12 // 12 months in a year
            case .from(let startDate, let endDate):
                // Intelligently determine what scale we are using.
                // Find the interval between the dates.
                let interval = startDate.distance(to: endDate)
                return Int(interval / 60 / 60)
        }
    }

}
