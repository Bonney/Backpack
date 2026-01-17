import XCTest
import UserNotifications
import CoreLocation
@testable import Backpack

final class NotificationContentTests: XCTestCase {

    // MARK: - Initialization Tests

    func testNotificationContentBasicInit() throws {
        let content = NotificationContent(
            title: "Test Title",
            body: "Test Body"
        )

        XCTAssertEqual(content.title, "Test Title")
        XCTAssertEqual(content.body, "Test Body")
        XCTAssertNil(content.subtitle)
        XCTAssertTrue(content.sound)
        XCTAssertNil(content.badge)
    }

    func testNotificationContentFullInit() throws {
        let id = UUID().uuidString
        let content = NotificationContent(
            id: id,
            title: "Full Test",
            subtitle: "Subtitle",
            body: "Body text",
            sound: false,
            badge: 5
        )

        XCTAssertEqual(content.id, id)
        XCTAssertEqual(content.title, "Full Test")
        XCTAssertEqual(content.subtitle, "Subtitle")
        XCTAssertEqual(content.body, "Body text")
        XCTAssertFalse(content.sound)
        XCTAssertEqual(content.badge, 5)
    }

    func testNotificationContentDefaultID() throws {
        let content = NotificationContent(title: "Test")

        // Should generate a UUID if not provided
        XCTAssertFalse(content.id.isEmpty)
    }

    // MARK: - UNNotificationContent Creation Tests

    func testMakeUNNotificationContentBasic() throws {
        let content = NotificationContent(
            title: "Test Title",
            body: "Test Body"
        )

        let unContent = content.makeUNNotificationContent()

        XCTAssertEqual(unContent.title, "Test Title")
        XCTAssertEqual(unContent.body, "Test Body")
        XCTAssertEqual(unContent.subtitle, "")
        XCTAssertEqual(unContent.sound, .default)
        XCTAssertNil(unContent.badge)
    }

    func testMakeUNNotificationContentWithSubtitle() throws {
        let content = NotificationContent(
            title: "Test Title",
            subtitle: "Test Subtitle",
            body: "Test Body"
        )

        let unContent = content.makeUNNotificationContent()

        XCTAssertEqual(unContent.title, "Test Title")
        XCTAssertEqual(unContent.subtitle, "Test Subtitle")
        XCTAssertEqual(unContent.body, "Test Body")
    }

    func testMakeUNNotificationContentWithoutSound() throws {
        let content = NotificationContent(
            title: "Silent",
            sound: false
        )

        let unContent = content.makeUNNotificationContent()

        XCTAssertNil(unContent.sound)
    }

    func testMakeUNNotificationContentWithBadge() throws {
        let content = NotificationContent(
            title: "Badge Test",
            badge: 10
        )

        let unContent = content.makeUNNotificationContent()

        XCTAssertEqual(unContent.badge, NSNumber(value: 10))
    }

    func testMakeUNNotificationContentWithAllFields() throws {
        let content = NotificationContent(
            id: "test-123",
            title: "Full Content",
            subtitle: "Subtitle",
            body: "Full body text",
            sound: true,
            badge: 3
        )

        let unContent = content.makeUNNotificationContent()

        XCTAssertEqual(unContent.title, "Full Content")
        XCTAssertEqual(unContent.subtitle, "Subtitle")
        XCTAssertEqual(unContent.body, "Full body text")
        XCTAssertNotNil(unContent.sound)
        XCTAssertEqual(unContent.badge, NSNumber(value: 3))
    }

    func testMakeUNNotificationContentWithNilBody() throws {
        let content = NotificationContent(
            title: "Just Title",
            body: nil
        )

        let unContent = content.makeUNNotificationContent()

        XCTAssertEqual(unContent.title, "Just Title")
        XCTAssertEqual(unContent.body, "")
    }
}

final class NotificationTriggerTests: XCTestCase {

    // MARK: - Date Trigger Tests

    func testDateTriggerCreation() throws {
        let futureDate = Date.tomorrow
        let trigger = NotificationTrigger.date(date: futureDate, repeats: false)

        let unTrigger = trigger.makeUNNotificationTrigger()

        XCTAssertTrue(unTrigger is UNCalendarNotificationTrigger)
        if let calendarTrigger = unTrigger as? UNCalendarNotificationTrigger {
            XCTAssertFalse(calendarTrigger.repeats)
        }
    }

    func testDateTriggerRepeating() throws {
        let date = Date(year: 2024, month: 6, day: 15, hour: 10, minute: 0)
        let trigger = NotificationTrigger.date(date: date, repeats: true)

        let unTrigger = trigger.makeUNNotificationTrigger()

        XCTAssertTrue(unTrigger is UNCalendarNotificationTrigger)
        if let calendarTrigger = unTrigger as? UNCalendarNotificationTrigger {
            XCTAssertTrue(calendarTrigger.repeats)
        }
    }

    func testDateTriggerDescription() throws {
        let date = Date(year: 2024, month: 6, day: 15)
        let trigger = NotificationTrigger.date(date: date, repeats: false)

        let description = trigger.description

        XCTAssertTrue(description.contains("Trigger"))
        XCTAssertFalse(description.contains("Repeating"))
    }

    func testDateTriggerDescriptionRepeating() throws {
        let date = Date(year: 2024, month: 6, day: 15)
        let trigger = NotificationTrigger.date(date: date, repeats: true)

        let description = trigger.description

        XCTAssertTrue(description.contains("Repeating"))
        XCTAssertTrue(description.contains("Trigger"))
    }

    // MARK: - Time Interval Trigger Tests

    func testTimeIntervalTriggerCreation() throws {
        let trigger = NotificationTrigger.time(timeInterval: 60, repeats: false)

        let unTrigger = trigger.makeUNNotificationTrigger()

        XCTAssertTrue(unTrigger is UNTimeIntervalNotificationTrigger)
        if let timeIntervalTrigger = unTrigger as? UNTimeIntervalNotificationTrigger {
            XCTAssertEqual(timeIntervalTrigger.timeInterval, 60)
            XCTAssertFalse(timeIntervalTrigger.repeats)
        }
    }

    func testTimeIntervalTriggerRepeating() throws {
        let trigger = NotificationTrigger.time(timeInterval: 3600, repeats: true)

        let unTrigger = trigger.makeUNNotificationTrigger()

        XCTAssertTrue(unTrigger is UNTimeIntervalNotificationTrigger)
        if let timeIntervalTrigger = unTrigger as? UNTimeIntervalNotificationTrigger {
            XCTAssertEqual(timeIntervalTrigger.timeInterval, 3600)
            XCTAssertTrue(timeIntervalTrigger.repeats)
        }
    }

    func testTimeIntervalTriggerDescription() throws {
        let trigger = NotificationTrigger.time(timeInterval: 120, repeats: false)

        let description = trigger.description

        XCTAssertTrue(description.contains("120"))
        XCTAssertTrue(description.contains("seconds"))
        XCTAssertFalse(description.contains("Repeating"))
    }

    func testTimeIntervalTriggerDescriptionRepeating() throws {
        let trigger = NotificationTrigger.time(timeInterval: 300, repeats: true)

        let description = trigger.description

        XCTAssertTrue(description.contains("Repeating"))
        XCTAssertTrue(description.contains("300"))
    }

    func testTimeIntervalTriggerMinimumDuration() throws {
        // System requires minimum 60 seconds for repeating triggers
        let trigger = NotificationTrigger.time(timeInterval: 60, repeats: true)

        let unTrigger = trigger.makeUNNotificationTrigger()

        XCTAssertNotNil(unTrigger)
    }

    // MARK: - Location Trigger Tests (iOS only)

    #if !os(macOS)
    func testLocationTriggerCreation() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        let trigger = NotificationTrigger.location(
            coordinates: coordinate,
            radius: 100,
            notifyOnEntry: true,
            notifyOnExit: false,
            repeats: false
        )

        let unTrigger = trigger.makeUNNotificationTrigger()

        XCTAssertTrue(unTrigger is UNLocationNotificationTrigger)
        if let locationTrigger = unTrigger as? UNLocationNotificationTrigger {
            XCTAssertFalse(locationTrigger.repeats)
            if let region = locationTrigger.region as? CLCircularRegion {
                XCTAssertEqual(region.center.latitude, 37.7749, accuracy: 0.0001)
                XCTAssertEqual(region.center.longitude, -122.4194, accuracy: 0.0001)
                XCTAssertEqual(region.radius, 100)
                XCTAssertTrue(region.notifyOnEntry)
                XCTAssertFalse(region.notifyOnExit)
            }
        }
    }

    func testLocationTriggerRepeating() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
        let trigger = NotificationTrigger.location(
            coordinates: coordinate,
            radius: 500,
            notifyOnEntry: false,
            notifyOnExit: true,
            repeats: true
        )

        let unTrigger = trigger.makeUNNotificationTrigger()

        XCTAssertTrue(unTrigger is UNLocationNotificationTrigger)
        if let locationTrigger = unTrigger as? UNLocationNotificationTrigger {
            XCTAssertTrue(locationTrigger.repeats)
            if let region = locationTrigger.region as? CLCircularRegion {
                XCTAssertFalse(region.notifyOnEntry)
                XCTAssertTrue(region.notifyOnExit)
            }
        }
    }

    func testLocationTriggerDescription() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let trigger = NotificationTrigger.location(
            coordinates: coordinate,
            radius: 200,
            notifyOnEntry: true,
            notifyOnExit: true,
            repeats: false
        )

        let description = trigger.description

        XCTAssertTrue(description.contains("Location"))
        XCTAssertTrue(description.contains("Trigger"))
    }

    func testLocationTriggerDescriptionRepeating() throws {
        let coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        let trigger = NotificationTrigger.location(
            coordinates: coordinate,
            radius: 200,
            notifyOnEntry: true,
            notifyOnExit: true,
            repeats: true
        )

        let description = trigger.description

        XCTAssertTrue(description.contains("Repeating"))
        XCTAssertTrue(description.contains("Location"))
    }
    #endif

    // MARK: - Trigger Comparison Tests

    func testMultipleTriggerTypes() throws {
        let dateTrigger = NotificationTrigger.date(date: Date.tomorrow, repeats: false)
        let timeTrigger = NotificationTrigger.time(timeInterval: 60, repeats: false)

        let unDateTrigger = dateTrigger.makeUNNotificationTrigger()
        let unTimeTrigger = timeTrigger.makeUNNotificationTrigger()

        XCTAssertTrue(unDateTrigger is UNCalendarNotificationTrigger)
        XCTAssertTrue(unTimeTrigger is UNTimeIntervalNotificationTrigger)
        XCTAssertFalse(unDateTrigger is UNTimeIntervalNotificationTrigger)
        XCTAssertFalse(unTimeTrigger is UNCalendarNotificationTrigger)
    }
}
