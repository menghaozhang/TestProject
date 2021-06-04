// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CalculatorProject",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "CalculatorProject",
            targets: ["CalculatorProject"]),
    ],
    targets: [
        .target(
            name: "CalculatorProject",
            dependencies: []),
        .testTarget(
            name: "CalculatorProjectTests",
            dependencies: ["CalculatorProject"]),
    ]
)
