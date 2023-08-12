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
        .library(name: "Backpack", targets: ["Backpack"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Backpack", dependencies: []),
    ]
)
