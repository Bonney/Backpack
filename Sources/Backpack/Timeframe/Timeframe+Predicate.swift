import Foundation

#if canImport(HealthKit)
import HealthKit

extension Timeframe {
    public func hkQuerySamplePredicate(options: HKQueryOptions = .strictStartDate) -> NSPredicate {
        let dates = self.dateRange
        return HKQuery.predicateForSamples(withStart: dates.lowerBound, end: dates.upperBound, options: options)
    }
}
#endif
