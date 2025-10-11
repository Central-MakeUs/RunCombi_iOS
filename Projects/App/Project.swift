//
//  Project.swift
//  RunCombi_iOSManifests
//
//  Created by 임경빈 on 6/25/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let shortVersionString: Plist.Value = "1.2.0"
let buildVersion: Plist.Value = "22"

let settings: Settings = .settings(
  base: [
    "DEVELOPMENT_TEAM": "\(AppEnvironment.developmentTeam)",
  ]
)

let infoPlist: InfoPlist = .extendingDefault(
  with: [
    "CFBundleDisplayName": "\(AppEnvironment.appName)",
    "CFBundleIconName": "AppIcon",
    "CFBundleShortVersionString": shortVersionString,
    "CFBundleVersion": buildVersion,
    "UILaunchScreen": [
      "UIColorName": "launchBackgroundColor",
      "UIImageName": ""
    ],
    "UIUserInterfaceStyle": "Dark",
    "UISupportedInterfaceOrientations": [
      "UIInterfaceOrientationPortrait",
    ],
    "LSApplicationQueriesSchemes": [
      "kakaokompassauth",
      "kakaolink",
    ],
    "CFBundleURLTypes": [
      [
        "CFBundleURLSchemes": [
          "kakao\(AppEnvironment.kakaoKey)"
        ]
      ]
    ],
    "NSAppTransportSecurity": [
      "NSAllowsArbitraryLoads": true
    ],
    "NSLocationAlwaysAndWhenInUseUsageDescription": "콤비와의 운동을 정확히 기록하기 위해 항상 위치 접근 권한이 필요해요.",
    "NSLocationWhenInUseUsageDescription": "콤비와 함께 운동 경로를 기록하기 위해 사용자의 위치가 필요해요.",
    "NSCameraUsageDescription": "콤비와 함께 운동 순간을 사진으로 남기기 위해 카메라 접근 권한이 필요해요.",
    "UIBackgroundModes": ["location"]
  ]
)

let project = Project.make(
  name: "App",
  settings: settings,
  targets: [
    .make(
      name: AppEnvironment.projectName,
      product: .app,
      bundleId: AppEnvironment.appBundleID,
      deploymentTargets: .iOS("17.0"),
      infoPlist: infoPlist,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      entitlements: "RunCombi.entitlements",
      dependencies: [
        .external(name: "GoogleMaps"),
        .project(
          target: "FeatureSplash",
          path: .relativeToRoot("Projects/Feature/Splash")
        ),
        .project(
          target: "FeatureMain",
          path: .relativeToRoot("Projects/Feature/Main")
        ),
        .project(
          target: "FeatureLogin",
          path: .relativeToRoot("Projects/Feature/Login")
        ),
        .project(
          target: "FeatureWatch",
          path: .relativeToRoot("Projects/Feature/Watch")
        ),
        .project(
          target: "SharedUtility",
          path: .relativeToRoot("Projects/Shared/Utility")
        ),
        .target(name: "RunCombiWatch")
      ],
      settings: .settings(
        base: [
          "CODE_SIGN_ENTITLEMENTS": "RunCombi.entitlements"
        ]
      )
    ),
    .make(
      name: "RunCombiWatch",
      destinations: .watchOS,
      product: .watch2App,
      bundleId: "\(AppEnvironment.appBundleID).watchapp",
      deploymentTargets: .watchOS("9.0"),
      infoPlist: .extendingDefault(with: [
        "CFBundleDisplayName": "\(AppEnvironment.appName)",
        "CFBundleShortVersionString": shortVersionString,
        "CFBundleVersion": buildVersion,
        "WKCompanionAppBundleIdentifier": "\(AppEnvironment.appBundleID)"
      ]),
      sources: [],
      resources: ["Watch/Resources/**"],
      dependencies: [
        .target(name: "RunCombiWatchExtension")
      ]
    ),
    .make(
      name: "RunCombiWatchExtension",
      destinations: .watchOS,
      product: .watch2Extension,
      bundleId: "\(AppEnvironment.appBundleID).watchapp.extension",
      deploymentTargets: .watchOS("9.0"),
      infoPlist: .extendingDefault(with: [
        "NSExtension": [
          "NSExtensionPointIdentifier": "com.apple.watchkit",
          "NSExtensionAttributes": [
            "WKAppBundleIdentifier": "\(AppEnvironment.appBundleID).watchapp"
          ]
        ],
        "NSLocationAlwaysAndWhenInUseUsageDescription": "콤비와의 운동을 정확히 기록하기 위해 항상 위치 접근 권한이 필요해요.",
        "NSLocationWhenInUseUsageDescription": "콤비와 함께 운동 경로를 기록하기 위해 사용자의 위치가 필요해요.",
        "UIBackgroundModes": ["location"],
        "NSAppTransportSecurity": [
          "NSAllowsArbitraryLoads": true
        ],
      ]),
      sources: ["Watch/Sources/**"],             // ← 코드 글롭은 여기로 이동
      resources: ["Watch/Resources/**"],      // ← 확장 리소스가 여기에만 있다면 유지
      dependencies: [
        .project(
          target: "SharedUtility",
          path: .relativeToRoot("Projects/Shared/Utility")
        ),
        .project(
          target: "CoreNetwork",
          path: .relativeToRoot("Projects/Core/Network")
        ),
        .project(
          target: "DomainLogin",
          path: .relativeToRoot("Projects/Domain/Login")
        ),
        .project(
          target: "DomainExercise",
          path: .relativeToRoot("Projects/Domain/Exercise")
        ),
      ]
    ),
  ]
)


