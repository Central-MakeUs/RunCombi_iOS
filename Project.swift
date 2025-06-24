import ProjectDescription

let project = Project(
    name: "RunCombi_iOS",
    targets: [
        .target(
            name: "RunCombi_iOS",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.RunCombi-iOS",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["RunCombi_iOS/Sources/**"],
            resources: ["RunCombi_iOS/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "RunCombi_iOSTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.RunCombi-iOSTests",
            infoPlist: .default,
            sources: ["RunCombi_iOS/Tests/**"],
            resources: [],
            dependencies: [.target(name: "RunCombi_iOS")]
        ),
    ]
)
