// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PolymorphCore",
    products: [
        .library(
            name: "PolymorphCore",
            targets: ["PolymorphCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/Digipolitan/string-case-swift.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "PolymorphCore",
            dependencies: ["StringCase"]),
        .testTarget(
            name: "PolymorphCoreTests",
            dependencies: ["PolymorphCore"])
    ]
)
