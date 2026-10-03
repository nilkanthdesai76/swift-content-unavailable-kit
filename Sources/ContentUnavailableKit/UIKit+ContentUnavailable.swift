import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit

private var emptyStateViewTag: Int = 90210

@MainActor
public extension UIViewController {
    /// Displays a standardized empty state over the view controller's view.
    func showEmptyState(configuration: ContentUnavailableConfiguration) {
        hideEmptyState()

        let emptyView = ContentUnavailableStateView(configuration: configuration)
        let hostingController = UIHostingController(rootView: emptyView)
        hostingController.view.tag = emptyStateViewTag
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(hostingController)
        view.addSubview(hostingController.view)

        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        hostingController.didMove(toParent: self)
    }

    /// Removes any currently displayed empty state view.
    func hideEmptyState() {
        for child in children {
            if child.view.tag == emptyStateViewTag {
                child.willMove(toParent: nil)
                child.view.removeFromSuperview()
                child.removeFromParent()
            }
        }
    }
}
#endif
