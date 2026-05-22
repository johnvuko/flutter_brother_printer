// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "brother_printer",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(name: "brother-printer", targets: ["brother_printer"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/johnvuko/BRLMPrinterKit.git",
            from: "4.13.1"
        )
    ],
    targets: [
        .target(
            name: "brother_printer",
            dependencies: [
                .product(name: "BRLMPrinterKit", package: "BRLMPrinterKit")
            ],
            resources: [],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("include/brother_printer")
            ]
        )
    ]
)
