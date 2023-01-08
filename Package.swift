// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JXSwiftUI",
    platforms: [ .macOS(.v12), .iOS(.v15), .tvOS(.v15) ],
    products: [
        .library(name: "JXSwiftUI", targets: ["JXSwiftUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jectivex/JXBridge.git", from: "0.1.15"),
    ],
    targets: [
        .target(name: "JXSwiftUI", dependencies: ["JXBridge"]),
        .testTarget(name: "JXSwiftUITests", dependencies: ["JXSwiftUI"]),
    ]
)
