// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [:]
    )
#endif

let package = Package(
    name: "RunCombi_iOS",
    dependencies: [
      .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.0")),
      .package(url: "https://github.com/airbnb/lottie-ios.git", .upToNextMajor(from: "4.5.0")),
      .package(url: "https://github.com/googlemaps/ios-maps-sdk.git", .upToNextMajor(from: "10.0.0")),
    ]
)
