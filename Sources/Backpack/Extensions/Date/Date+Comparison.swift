import Foundation

public extension Date {
    
    /// Returns `true` when both Dates contain the same supplied DateComponents.
    func isSame(as comparisonDate: Date, whenComparing componentsToCompare: Set<Calendar.Component>) -> Bool {
        let componentsForSelf = Calendar.current.dateComponents(componentsToCompare, from: self)
        let componentsToCompare = Calendar.current.dateComponents(componentsToCompare, from: comparisonDate)
        return (componentsForSelf == componentsToCompare)
    }

    /// Returns `true` when both Dates have the same Year, Month, and Day.
    func isOnTheSameDay(as comparisonDate: Date) -> Bool {
        return isSame(as: comparisonDate, whenComparing: [.year, .month, .day])
    }

    /// Returns `true` when both Dates have the same Year and Week of Year.
    func isInTheSameWeek(as comparisonDate: Date) -> Bool {
        self .isSame(as: comparisonDate, whenComparing: [.year, .weekOfYear])
    }

    /// Returns `true` when both Dates have the same Year and Month.
    func isInTheSameMonth(as comparisonDate: Date) -> Bool {
        self .isSame(as: comparisonDate, whenComparing: [.year, .month])
    }

    /// Returns `true` when both Dates have the same Year.
    func isInTheSameYear(as comparisonDate: Date) -> Bool {
        self .isSame(as: comparisonDate, whenComparing: [.year])
    }

    func isInTheNext(number count: Int, of component: Calendar.Component) -> Bool {
        let now = Date()
        guard let forwardDate = Calendar.current.date(byAdding: component, value: count, to: now) else {
            return false
        }
        return self >= now && self < forwardDate
    }

    func isInTheLast(number count: Int, of component: Calendar.Component) -> Bool {
        let now = Date()
        guard let backwardDate = Calendar.current.date(byAdding: component, value: -count, to: now) else {
            return false
        }
        return self > backwardDate && self <= now
    }

}
