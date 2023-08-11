// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Backpack",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .watchOS(.v9)
    ],
    products: [
        .library(name: "Colors", targets: ["Colors"]),
        .library(name: "Extensions", targets: ["Extensions"]),
        .library(name: "Views", targets: ["Views"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Extensions", dependencies: []),
        .target(name: "Views", dependencies: ["Extensions"]),
        .target(name: "Colors", dependencies: [.byName(name: "Extensions"), .byName(name: "Views")])
    ]
)
