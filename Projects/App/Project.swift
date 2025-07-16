//
//  Project.swift
//  RunCombi_iOSManifests
//
//  Created by 임경빈 on 6/25/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let settings: Settings = .settings(
  base: [
    "DEVELOPMENT_TEAM": "\(AppEnvironment.developmentTeam)",
    "CODE_SIGN_ENTITLEMENTS": "RunCombi.entitlements"
  ]
)

let infoPlist: InfoPlist = .extendingDefault(
  with: [
    "CFBundleDisplayName": "\(AppEnvironment.appName)",
    "CFBundleIconName": "AppIcon",
    "CFBundleShortVersionString": "0.0",
    "CFBundleVersion": "3",
    "UILaunchScreen": [
      "UIColorName": "launchBackgroundColor",
      "UIImageName": ""
    ],
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
    "NSLocationAlwaysAndWhenInUseUsageDescription": "콤비와의 운동을 정확히 기록하기 위해 항상 위치 접근 권한이 필요합니다.",
    "NSLocationWhenInUseUsageDescription": "콤비와 함께 운동 경로를 기록하기 위해 사용자의 위치가 필요해요.",
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
          target: "SharedUtility",
          path: .relativeToRoot("Projects/Shared/Utility")
        ),
      ]
    )
  ]
)


