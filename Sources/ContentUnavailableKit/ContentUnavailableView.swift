import SwiftUI

/// Declarative empty state view compatible with iOS 15+, macOS 12+, and tvOS 15+.
public struct ContentUnavailableStateView: View {
    public let configuration: ContentUnavailableConfiguration

    public init(configuration: ContentUnavailableConfiguration) {
        self.configuration = configuration
    }

    public var body: some View {
        VStack(spacing: 16) {
            Spacer()

            if let systemImage = configuration.systemImage {
                Image(systemName: systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56, height: 56)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
            }

            VStack(spacing: 8) {
                Text(configuration.title)
                    .font(.title2.weight(.bold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)

                if let description = configuration.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }
            }

            if configuration.primaryAction != nil || configuration.secondaryAction != nil {
                VStack(spacing: 12) {
                    if let primary = configuration.primaryAction {
                        Button(action: primary.action) {
                            Text(primary.title)
                                .font(.body.weight(.semibold))
                                .padding(.horizontal, 24)
                                .padding(.vertical, 10)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.regular)
                    }

                    if let secondary = configuration.secondaryAction {
                        Button(action: secondary.action) {
                            Text(secondary.title)
                                .font(.subheadline.weight(.medium))
                        }
                        .buttonStyle(.borderless)
                    }
                }
                .padding(.top, 8)
            }

            Spacer()
        }
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
