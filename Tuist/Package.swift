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
      .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.3.1"),
      .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.4.0"),
      .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.10.0")),
      .package(url: "https://github.com/airbnb/lottie-ios.git", .upToNextMajor(from: "4.5.0")),
      .package(url: "https://github.com/googlemaps/ios-maps-sdk.git", .upToNextMajor(from: "10.0.0")),
      .package(url: "https://github.com/kakao/kakao-ios-sdk", .upToNextMajor(from: "2.24.0")),
      .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", .upToNextMajor(from: "4.2.2")),
    ]
)
