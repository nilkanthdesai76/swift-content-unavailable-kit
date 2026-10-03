import Foundation
import SwiftUI

/// Defines an action button presented within an empty state view.
public struct ContentUnavailableAction: Sendable {
    public let title: String
    public let action: @Sendable () -> Void

    public init(title: String, action: @escaping @Sendable () -> Void) {
        self.title = title
        self.action = action
    }
}

/// Unified description of an empty or unavailable content state.
public struct ContentUnavailableConfiguration: Sendable {
    public var title: String
    public var description: String?
    public var systemImage: String?
    public var primaryAction: ContentUnavailableAction?
    public var secondaryAction: ContentUnavailableAction?

    public init(
        title: String,
        description: String? = nil,
        systemImage: String? = nil,
        primaryAction: ContentUnavailableAction? = nil,
        secondaryAction: ContentUnavailableAction? = nil
    ) {
        self.title = title
        self.description = description
        self.systemImage = systemImage
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }

    /// Preset for search results unavailable state.
    public static func search(query: String, onClear: (@Sendable () -> Void)? = nil) -> ContentUnavailableConfiguration {
        let action = onClear.map { ContentUnavailableAction(title: "Clear Search", action: $0) }
        return ContentUnavailableConfiguration(
            title: "No Results for \"\(query)\"",
            description: "Check the spelling or try searching with different keywords.",
            systemImage: "magnifyingglass",
            primaryAction: action
        )
    }

    /// Preset for offline / network unavailable state.
    public static func networkUnavailable(onRetry: @escaping @Sendable () -> Void) -> ContentUnavailableConfiguration {
        ContentUnavailableConfiguration(
            title: "No Internet Connection",
            description: "Please check your network settings and try again.",
            systemImage: "wifi.slash",
            primaryAction: ContentUnavailableAction(title: "Retry", action: onRetry)
        )
    }

    /// Preset for empty collection/list state.
    public static func empty(
        title: String,
        description: String? = nil,
        systemImage: String? = "tray",
        actionTitle: String? = nil,
        action: (@Sendable () -> Void)? = nil
    ) -> ContentUnavailableConfiguration {
        let primaryAction: ContentUnavailableAction?
        if let actionTitle = actionTitle, let action = action {
            primaryAction = ContentUnavailableAction(title: actionTitle, action: action)
        } else {
            primaryAction = nil
        }

        return ContentUnavailableConfiguration(
            title: title,
            description: description,
            systemImage: systemImage,
            primaryAction: primaryAction
        )
    }

    /// Preset for permission denied state (camera, photos, location).
    public static func permissionDenied(
        permissionName: String,
        onOpenSettings: @escaping @Sendable () -> Void
    ) -> ContentUnavailableConfiguration {
        ContentUnavailableConfiguration(
            title: "\(permissionName) Access Required",
            description: "To use this feature, grant permission in device settings.",
            systemImage: "lock.shield",
            primaryAction: ContentUnavailableAction(title: "Open Settings", action: onOpenSettings)
        )
    }
}
