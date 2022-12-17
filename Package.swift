// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JXSwiftUI",
    platforms: [ .macOS(.v12), .iOS(.v15), .tvOS(.v15) ],
    products: [
        .library(name: "JXSwiftUI", targets: ["JXSwiftUI"]),
    ],
    dependencies: [ .package(name: "swift-docc-plugin", url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"), 
        .package(url: "https://github.com/jectivex/JXBridge.git", from: "0.1.9"),
        .package(url: "https://github.com/jectivex/JXKit.git", from: "3.3.4"),
    ],
    targets: [
        .target(name: "JXSwiftUI", dependencies: ["JXBridge", "JXKit"]),
        .testTarget(name: "JXSwiftUITests", dependencies: ["JXSwiftUI"]),
    ]
)
