// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Backpack",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
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
