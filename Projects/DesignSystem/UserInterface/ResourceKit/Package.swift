// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ResourceKit",
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(name: "ResourceKit", targets: ["ResourceKit"])
  ],
  dependencies: [
    .package(url: "https://github.com/mac-cain13/R.swift.git", from: "7.0.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package, defining a module or a test suite.
    // Targets can depend on other targets in this package and products from dependencies.
    .target(
      name: "ResourceKit",
      dependencies: [
        .product(name: "RswiftLibrary", package: "R.swift")
      ],
      resources: [.process("Resources")],
      plugins: [.plugin(name: "RswiftGeneratePublicResources", package: "R.swift")]
    )
  ]
)

