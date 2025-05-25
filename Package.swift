// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OklchColorPicker",
    platforms: [
        .iOS(.v17), .macOS(.v14)
    ],
    products: [
        .library(name: "OklchColorPicker", targets: ["OklchColorPicker"])
    ],
    dependencies: [
        .package(url: "https://github.com/HarshilShah/ChromaKit", branch: "main"),
        .package(url: "https://github.com/Bonney/Backpack", branch: "main")
    ],
    targets: [
        .target(
            name: "OklchColorPicker",
            dependencies: [
                .product(name: "ChromaKit", package: "ChromaKit"),
                .product(name: "Backpack", package: "Backpack")
            ]
        ),
    ]
)
