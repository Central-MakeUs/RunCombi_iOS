// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // nanopb/FBLPromises(Firebase 전이 의존성)는 정적 링킹 시 분리되는
        // 개인정보 매니페스트 번들이 아카이브에서 빌드되지 않는 문제가 있어 동적으로 전환
        productTypes: [
            "nanopb": .framework,
            "FBLPromises": .framework,
        ]
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
      .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "11.0.0")),
    ]
)
