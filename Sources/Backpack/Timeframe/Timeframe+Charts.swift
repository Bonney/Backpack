import Foundation

// MARK: - Extensions for SwiftCharts

extension Timeframe {

    public static var defaultChartTimeframes: [Timeframe] {
        [.today, .weekToDate, .monthToDate, .yearToDate]
    }

    public var displayName: String {
        switch self {
            case .allTime:
                return "All Time"
            case .today:
                return "Day"
            case .weekToDate:
                return "Week"
            case .monthToDate:
                return "Month"
            case .yearToDate:
                return "Year"
            case .pastDays(let days):
                return "\(days) Days"
            case .pastWeeks(let weeks):
                return "\(weeks) Weeks"
            case .pastMonths(let months):
                return "\(months) Months"
            case .range(_, _):
                return "Custom Range"
        }
    }

    /// The number of x-axis columns to use for a given Timeframe.
    public var chartXAxisSubdivisions: Int {
        switch self {
            case .allTime:
                return 1
            case .today:
                return 24 // 24 hours in a day.
            case .weekToDate:
                return 7 // 7 days in a week
            case .monthToDate:
                return Date.now.daysInMonth // 28/29, 30, or 31 days per month
            case .yearToDate:
                return 12 // 12 months in a year
            case .pastDays(let days):
                return days
            case .pastWeeks(let weeks):
                return weeks
            case .pastMonths(let months):
                return months
            case .range(let startDate, let endDate):
                // Intelligently determine what scale we are using.
                // Find the interval between the dates.
                let interval = startDate.distance(to: endDate)
                return Int(interval / 60 / 60)
        }
    }

}
