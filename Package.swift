// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift Package Manager required to build this package.

import PackageDescription

let package = Package(
    name: "Texture",
    platforms: [
        .iOS(.v14),
        .tvOS(.v14),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "AsyncDisplayKit",
            targets: ["AsyncDisplayKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pinterest/PINRemoteImage.git", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "AsyncDisplayKit",
            dependencies: [
                .product(name: "PINRemoteImage", package: "PINRemoteImage"),
            ],
            path: "Source",
            exclude: [
                "Info.plist",
                "AsyncDisplayKit.modulemap",
            ],
            publicHeadersPath: "include",
            cSettings: [
                .define("AS_PIN_REMOTE_IMAGE", to: "1"),
                .define("AS_USE_VIDEO", to: "1"),
                .define("AS_USE_MAPKIT", to: "1"),
                .define("AS_USE_PHOTOS", to: "1"),
                .unsafeFlags(["-fno-exceptions"]),
                // Header search paths for quoted #import "..." in .mm files
                .headerSearchPath("Private"),
                .headerSearchPath("Private/Layout"),
                .headerSearchPath("TextKit"),
                .headerSearchPath("TextExperiment"),
                .headerSearchPath("TextExperiment/Component"),
                .headerSearchPath("TextExperiment/String"),
                .headerSearchPath("TextExperiment/Utility"),
                .headerSearchPath("Details"),
                .headerSearchPath("Details/Transactions"),
                .headerSearchPath("Base"),
                .headerSearchPath("Debug"),
                .headerSearchPath("Layout"),
                .headerSearchPath("tvOS"),
            ],
            cxxSettings: [
                .define("AS_PIN_REMOTE_IMAGE", to: "1"),
                .define("AS_USE_VIDEO", to: "1"),
                .define("AS_USE_MAPKIT", to: "1"),
                .define("AS_USE_PHOTOS", to: "1"),
                .unsafeFlags(["-fno-exceptions"]),
                // Header search paths for quoted #import "..." in .mm files
                .headerSearchPath("Private"),
                .headerSearchPath("Private/Layout"),
                .headerSearchPath("TextKit"),
                .headerSearchPath("TextExperiment"),
                .headerSearchPath("TextExperiment/Component"),
                .headerSearchPath("TextExperiment/String"),
                .headerSearchPath("TextExperiment/Utility"),
                .headerSearchPath("Details"),
                .headerSearchPath("Details/Transactions"),
                .headerSearchPath("Base"),
                .headerSearchPath("Debug"),
                .headerSearchPath("Layout"),
                .headerSearchPath("tvOS"),
            ],
            linkerSettings: [
                .unsafeFlags(["-ObjC"]),
                .linkedLibrary("c++"),
                .linkedFramework("UIKit"),
                .linkedFramework("QuartzCore"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("CoreText"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("CoreMedia"),
                .linkedFramework("MapKit", .when(platforms: [.iOS])),
                .linkedFramework("CoreLocation", .when(platforms: [.iOS])),
                .linkedFramework("Photos"),
            ]
        ),
    ]
)
