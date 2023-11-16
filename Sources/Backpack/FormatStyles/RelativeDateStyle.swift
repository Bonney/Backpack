import SwiftUI
import Foundation

public struct RelativeDateStyle: FormatStyle {
    public typealias FormatInput = Date
    public typealias FormatOutput = String

    public func format(_ value: Date) -> String {

        if value.isOnTheSameDay(as: Date.now) {
            return "Today " + value.formatted(date: .omitted, time: .shortened)
        }

        if value < Date.now {
            return format(pastDate: value)
        }

        if value > Date.now {
            return format(currentOrFutureDate: value)
        }

        return "!?"
    }

    private func format(pastDate: Date) -> String {
        if pastDate.isInTheLast(number: 1, of: .day) {
            return "Yesterday " + pastDate.formatted(date: .omitted, time: .shortened)
        }
        let formatter = Date.FormatStyle(date: .abbreviated, time: .omitted)
        return formatter.format(pastDate)
    }

    func format(currentOrFutureDate: Date) -> String {
        if currentOrFutureDate.isInTheSameWeek(as: Date.now) {
            let formatter = Date.FormatStyle().weekday()
            return formatter.format(currentOrFutureDate)
        }

        if currentOrFutureDate.isInTheSameMonth(as: Date.now) {
            return "This Month"
        }

        let formatter = Date.FormatStyle(date: .abbreviated, time: .omitted)
        return formatter.format(currentOrFutureDate)
    }
}

extension FormatStyle where Self == RelativeDateStyle {
    public static var relative: RelativeDateStyle {
        RelativeDateStyle()
    }
}

#Preview {
    List {
        ForEach([-7, -5, -2, -1, 0, 1, 6, 8, 14, 32, 100, 377], id: \.self) { index in
            let date = Date.now.addingTimeInterval(TimeInterval(84_600 * index))
            LabeledContent {
                Text(date.formatted())
            } label: {
                Text(date.formatted(.relative))
            }
        }
    }
}
