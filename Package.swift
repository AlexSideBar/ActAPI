// swift-tools-version: 6.0

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "ActAPIFramework",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "ActAPIFramework",
            type: .static,
            targets: ["ActAPIFramework"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/DanielEdrisian/swift-syntax-pruned.git", branch: "main"),
    ],
    targets: [
        .binaryTarget(
            name: "ActAPIXCFramework",
            path: "./ActAPIXCFramework.xcframework"
        ),
        .macro(
            name: "ActAPIMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax-pruned"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax-pruned")
            ],
            swiftSettings: [
                .define("RESILIENT_LIBRARIES")
            ]
        ),
        .target(
            name: "ActAPIFramework",
            dependencies: [
                "ActAPIMacros",
                .target(name: "ActAPIXCFramework")
            ],
            linkerSettings: [
                .linkedFramework("ActAPIXCFramework"),
            ]
        )
    ]
)
