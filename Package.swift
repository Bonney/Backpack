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
        .library(name: "Backpack", targets: ["Backpack"]),
        .library(name: "OklchColorPicker", targets: ["OklchColorPicker"]),
    ],
    dependencies: [
        .package(url: "https://github.com/HarshilShah/ChromaKit", branch: "main"),
    ],
    targets: [
        .target(
            name: "Backpack",
            dependencies: [],
            resources: [.process("Colors/Colors.xcassets")]
        ),
        .target(
            name: "OklchColorPicker",
            dependencies: [
                "Backpack",
                .product(name: "ChromaKit", package: "ChromaKit"),
            ]
        ),
        .testTarget(
            name: "BackpackTests",
            dependencies: ["Backpack"]
        ),
    ]
)
