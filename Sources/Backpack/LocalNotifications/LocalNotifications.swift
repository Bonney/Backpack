import os
import UIKit
import Combine
import Foundation
import CoreLocation
import UserNotifications

/// A class that manages local notifications for the app.
@MainActor public final class LocalNotifications: ObservableObject {
    private static let logger = Logger(subsystem: "LocalNotifications", category: "LocalNotifications")

    // MARK: - Lifecycle

    public static let shared = LocalNotifications()

    /// Do not initialize the class directly; instead, access the static shared instance.
    private init() {
        LocalNotifications.logger.info("LocalNotifications class initialized.")
    }

    deinit {
        LocalNotifications.logger.info("LocalNotifications de-initializing.")
    }

    /// The shared instance of `UNUserNotificationCenter` that is used to schedule notifications.
    private let instance = UNUserNotificationCenter.current()

    /// Open the Settings App on user's device.
    ///
    /// If user has previously denied notification authorization, the OS prompt will not appear again. The user will need to manually turn notifications in Settings.
    #if os(iOS)
    public func openAppSettings() throws {
        guard let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) else {
            throw URLError(.badURL)
        }
        UIApplication.shared.open(url)
    }
    #endif

    /// The number currently set as the badge of the app icon on the Home Screen.
    #if os(iOS)
    public var applicationIconBadgeNumber: Int {
        UIApplication.shared.applicationIconBadgeNumber
    }
    #endif

    public func getPendingNotificationRequests() async -> [UNNotificationRequest] {
        LocalNotifications.logger.info("Getting pending notification requests.")
        return await withCheckedContinuation { continuation in
            instance.getPendingNotificationRequests { notifications in
                LocalNotifications.logger.info("Found \(notifications.count) pending notification requests.")
                continuation.resume(returning: notifications)
            }
        }
    }
}

// MARK: - Authorization
extension LocalNotifications {
    /// Requests the user's authorization to allow local and remote notifications.
    @discardableResult
    public func requestAuthorization(options: UNAuthorizationOptions = [.alert, .sound, .badge]) async throws -> Bool {
        LocalNotifications.logger.info("Requesting authorization for \(String(describing: options)).")
        return try await instance.requestAuthorization(options: options)
    }

    /// Retrieves the notification authorization settings for your app.
    ///
    /// - .authorized = User previously granted permission for notifications
    /// - .denied = User previously denied permission for notifications
    /// - .notDetermined = Notification permission hasn't been asked yet.
    /// - .provisional = The application is authorized to post non-interruptive user notifications (iOS 12.0+)
    /// - .ephemeral = The application is temporarily authorized to post notifications - available to App Clips only (iOS 14.0+)
    ///
    /// - Returns: User's authorization status
    public func getNotificationAuthorizationStatus() async throws -> UNAuthorizationStatus {
        LocalNotifications.logger.info("Getting notification authorization status.")
        return await withCheckedContinuation { continuation in
            instance.getNotificationSettings { settings in
                continuation.resume(returning: settings.authorizationStatus)
                return
            }
        }
    }
}

// MARK: - Removing Scheduled Notifications
extension LocalNotifications {
    /// Cancel all pending notifications.
    public func removeAllPendingNotifications() {
        instance.removeAllPendingNotificationRequests()
    }

    // Remove all delivered notifications (notifications that have previously triggered)
    public func removeAllDeliveredNotifications() {
        instance.removeAllDeliveredNotifications()
    }

    /// Remove notifications by ID
    ///
    /// - Parameters:
    ///   - ids: ID associated with scheduled notification.
    ///   - pending: Cancel pending notifications (notifications that are in the queue and have not yet triggered)
    ///   - delivered: Remove delivered notifications (notifications that have previously triggered)
    func removeNotifications(ids: [String], pending: Bool = true, delivered: Bool = true) {
        if pending {
            instance.removePendingNotificationRequests(withIdentifiers: ids)
        }
        if delivered {
            instance.removeDeliveredNotifications(withIdentifiers: ids)
        }
    }
}

// MARK: - Scheduling New Notifications
extension LocalNotifications {
    /// Schedule a local notification.
    public func scheduleNotification(_ content: NotificationContent, trigger: NotificationTrigger) async throws {
        LocalNotifications.logger.info("Scheduling notification with content: \(String(describing: content)) and trigger: \(String(describing: trigger)).")

        let currentAuthStatus = try await getNotificationAuthorizationStatus()
        LocalNotifications.logger.info("Current notification authorization status: \(String(describing: currentAuthStatus)).")
        
        if currentAuthStatus == .notDetermined {
            LocalNotifications.logger.info("Notification authorization status not determined. Requesting authorization.")
            try await requestAuthorization()
        }

        let notificationContent = content.makeUNNotificationContent()
        let notificationTrigger = trigger.makeUNNotificationTrigger()

        LocalNotifications.logger.info("Adding notification with identifier: \(content.id).")
        try await addNotification(identifier: content.id, content: notificationContent, trigger: notificationTrigger)
    }

    private func addNotification(identifier: String?, content: UNNotificationContent, trigger: UNNotificationTrigger) async throws {

        let request = UNNotificationRequest(
            identifier: identifier ?? UUID().uuidString,
            content: content,
            trigger: trigger
        )

        try await instance.add(request)
        objectWillChange.send()
    }
}
