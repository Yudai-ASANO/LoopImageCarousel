// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoopImageCarousel",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "LoopImageCarousel",
            targets: ["LoopImageCarousel"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.52.11")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "LoopImageCarousel"),
        .testTarget(
            name: "LoopImageCarouselTests",
            dependencies: ["LoopImageCarousel"]),
    ]
)
