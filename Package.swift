// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "DangerIBLinter",
    products: [
        .library(
            name: "DangerIBLinter",
            targets: ["DangerIBLinter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/danger/danger-swift.git", from: "0.3.0")
    ],
    targets: [
        .target(
            name: "DangerIBLinter",
            dependencies: ["Danger"]),
        .testTarget(
            name: "DangerIBLinterTests",
            dependencies: ["DangerIBLinter"]),
    ]
)
