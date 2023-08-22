import os
import Foundation
import CoreLocation
import UserNotifications

// Possible triggers for notifications.
public enum NotificationTrigger {
    /// A notification trigger that fires on a specific date and time.
    case date(date: Date, repeats: Bool)

    /// A notification trigger that fires after the specified amount of time elapses.
    case time(timeInterval: TimeInterval, repeats: Bool)

    /// A notification trigger that fires when the user enters or exits the specified region.
    @available(iOS 10.0, *)
    @available(macOS, unavailable, message: "Location-based Notification triggers are not supported on macOS.")
    case location(coordinates: CLLocationCoordinate2D, radius: CLLocationDistance, notifyOnEntry: Bool, notifyOnExit: Bool, repeats: Bool)
}

extension NotificationTrigger: CustomStringConvertible {
    public var description: String {
        switch self {
            case .date(let date, let repeats):
                return "\(repeats ? "Repeating " : "")Trigger on \(date.formatted(date: .numeric, time: .shortened))"
            case .time(let timeInterval, let repeats):
                return "\(repeats ? "Repeating " : "")Trigger after \(timeInterval) seconds"
            case .location(_, _, _, _, let repeats):
                return "Location-Based \(repeats ? "Repeating " : "")Trigger."
        }
    }
}

extension NotificationTrigger {
    private static let logger = Logger(subsystem: "NotificationTrigger", category: "NotificationTrigger")

    func makeUNNotificationTrigger() -> UNNotificationTrigger {
        switch self {
            case .date(let date, let repeats):
                NotificationTrigger.logger.info("Creating UNCalendarNotificationTrigger for Date: \(date.formatted()), Repeating: \(repeats).")
                let components = Calendar.current.dateComponents([.second, .month, .hour, .day, .month, .year], from: date)
                return UNCalendarNotificationTrigger(dateMatching: components, repeats: repeats)

            case .time(let timeInterval, let repeats):
                NotificationTrigger.logger.info("Creating UNTimeIntervalNotificationTrigger for TimeInterval: \(timeInterval), Repeating: \(repeats).")
                return UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)

                #if !os(macOS)

            case .location(let coordinates, let radius, let notifyOnEntry, let notifyOnExit, let repeats):
                NotificationTrigger.logger.info("Creating UNLocationNotificationTrigger for Coordinates: \("LAT\(coordinates.latitude.description) LON\(coordinates.longitude.description)"), Radius: \(radius), NotifyOnEntry: \(notifyOnEntry), NotifyOnExit: \(notifyOnExit), Repeating: \(repeats).")
                let region = CLCircularRegion(center: coordinates, radius: radius, identifier: UUID().uuidString)
                region.notifyOnEntry = notifyOnEntry
                region.notifyOnExit = notifyOnExit
                return UNLocationNotificationTrigger(region: region, repeats: repeats)

                #endif
        }
    }
}
