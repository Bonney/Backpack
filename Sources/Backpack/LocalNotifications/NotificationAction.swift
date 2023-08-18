import Foundation
import UserNotifications

public enum NotificationAction {

}

extension NotificationAction {
    static func defaultAction() -> UNNotificationAction {
        let action = UNNotificationAction(identifier: UUID().uuidString, title: "Default Action")
        return action
    }
}
