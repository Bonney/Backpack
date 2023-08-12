import Foundation

#if canImport(HealthKit)
import HealthKit

extension Timeframe {
    public func hkQuerySamplePredicate(options: HKQueryOptions = .strictStartDate) -> NSPredicate {
        let dates = self.dates
        return HKQuery.predicateForSamples(withStart: dates.start, end: dates.end, options: options)
    }
}
#endif
