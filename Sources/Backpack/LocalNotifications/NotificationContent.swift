import Backpack
import Foundation
import UserNotifications

public struct NotificationContent {
    let id: String
    let title: String
    let subtitle: String?
    let body: String?
    let sound: Bool
    let badge: Int?

    public init(
        id: String = UUID().uuidString,
        title: String,
        subtitle: String? = nil,
        body: String? = nil,
        sound: Bool = true,
        badge: Int? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.body = body
        self.sound = sound
        self.badge = badge
    }
}

extension NotificationContent {
    public func makeUNNotificationContent() -> UNNotificationContent {
        // Builder for UNNotificationContent
        let content = UNMutableNotificationContent()

        // Set the title.
        content.title = title

        if let subtitle {
            content.subtitle = subtitle
        }

        // Set the body content.
        if let body {
            content.body = body
        }

        // Set if the alert plays a sound.
        if sound {
            content.sound = .default
        }

        // Set the badge count if applicable.
        if let badge {
            content.badge = NSNumber(integerLiteral: badge)
        }

        return content
    }
}
