// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "swift-content-unavailable-kit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "ContentUnavailableKit",
            targets: ["ContentUnavailableKit"]
        ),
    ],
    targets: [
        .target(
            name: "ContentUnavailableKit",
            dependencies: [],
            path: "Sources/ContentUnavailableKit"
        ),
        .testTarget(
            name: "ContentUnavailableKitTests",
            dependencies: ["ContentUnavailableKit"],
            path: "Tests/ContentUnavailableKitTests"
        ),
    ]
)
