import SwiftUI

public struct ContentUnavailableOverlayModifier: ViewModifier {
    public let isUnavailable: Bool
    public let configuration: ContentUnavailableConfiguration

    public init(isUnavailable: Bool, configuration: ContentUnavailableConfiguration) {
        self.isUnavailable = isUnavailable
        self.configuration = configuration
    }

    public func body(content: Content) -> some View {
        ZStack {
            if isUnavailable {
                ContentUnavailableStateView(configuration: configuration)
                    .transition(.opacity.combined(with: .scale(scale: 0.96)))
            } else {
                content
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isUnavailable)
    }
}

public extension View {
    /// Conditionally replaces the view content with an empty state when `isUnavailable` is true.
    func contentUnavailable(when isUnavailable: Bool, configuration: ContentUnavailableConfiguration) -> some View {
        modifier(ContentUnavailableOverlayModifier(isUnavailable: isUnavailable, configuration: configuration))
    }

    /// Displays a standardized empty search results state when `isUnavailable` is true.
    func searchUnavailable(when isUnavailable: Bool, query: String, onClear: (@Sendable () -> Void)? = nil) -> some View {
        contentUnavailable(when: isUnavailable, configuration: .search(query: query, onClear: onClear))
    }

    /// Displays an offline/network error state when `isOffline` is true.
    func networkUnavailable(when isOffline: Bool, onRetry: @escaping @Sendable () -> Void) -> some View {
        contentUnavailable(when: isOffline, configuration: .networkUnavailable(onRetry: onRetry))
    }

    /// Displays an empty list/collection state with optional creation action.
    func emptyState(
        when isEmpty: Bool,
        title: String,
        description: String? = nil,
        systemImage: String? = "tray",
        actionTitle: String? = nil,
        action: (@Sendable () -> Void)? = nil
    ) -> some View {
        contentUnavailable(
            when: isEmpty,
            configuration: .empty(
                title: title,
                description: description,
                systemImage: systemImage,
                actionTitle: actionTitle,
                action: action
            )
        )
    }
}
