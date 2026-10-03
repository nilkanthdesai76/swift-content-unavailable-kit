import XCTest
@testable import ContentUnavailableKit

private final class TestBox<T>: @unchecked Sendable {
    var value: T
    init(_ value: T) { self.value = value }
}

final class ContentUnavailableKitTests: XCTestCase {

    func testPresetSearchConfiguration() {
        let cleared = TestBox(false)
        let config = ContentUnavailableConfiguration.search(query: "Photos") {
            cleared.value = true
        }

        XCTAssertTrue(config.title.contains("Photos"))
        XCTAssertEqual(config.systemImage, "magnifyingglass")
        XCTAssertNotNil(config.primaryAction)
        XCTAssertEqual(config.primaryAction?.title, "Clear Search")

        config.primaryAction?.action()
        XCTAssertTrue(cleared.value)
    }

    func testPresetNetworkUnavailableConfiguration() {
        let retried = TestBox(false)
        let config = ContentUnavailableConfiguration.networkUnavailable {
            retried.value = true
        }

        XCTAssertEqual(config.title, "No Internet Connection")
        XCTAssertEqual(config.systemImage, "wifi.slash")
        XCTAssertEqual(config.primaryAction?.title, "Retry")

        config.primaryAction?.action()
        XCTAssertTrue(retried.value)
    }

    func testPresetEmptyConfiguration() {
        let config = ContentUnavailableConfiguration.empty(
            title: "No Favorites",
            description: "Tap the star to add items to your favorites list.",
            systemImage: "star"
        )

        XCTAssertEqual(config.title, "No Favorites")
        XCTAssertEqual(config.description, "Tap the star to add items to your favorites list.")
        XCTAssertEqual(config.systemImage, "star")
        XCTAssertNil(config.primaryAction)
    }

    func testPresetPermissionDeniedConfiguration() {
        let settingsOpened = TestBox(false)
        let config = ContentUnavailableConfiguration.permissionDenied(permissionName: "Camera") {
            settingsOpened.value = true
        }

        XCTAssertEqual(config.title, "Camera Access Required")
        XCTAssertEqual(config.systemImage, "lock.shield")
        XCTAssertEqual(config.primaryAction?.title, "Open Settings")

        config.primaryAction?.action()
        XCTAssertTrue(settingsOpened.value)
    }

    func testActionExecution() {
        let count = TestBox(0)
        let action = ContentUnavailableAction(title: "Perform") {
            count.value += 1
        }

        XCTAssertEqual(action.title, "Perform")
        action.action()
        XCTAssertEqual(count.value, 1)
    }
}
