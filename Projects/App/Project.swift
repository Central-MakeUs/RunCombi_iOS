//
//  Project.swift
//  RunCombi_iOSManifests
//
//  Created by 임경빈 on 6/25/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "App",
  targets: [
    .make(
      name: "RunCombi",
      product: .app,
      bundleId: "com.Combo.RunCombi",
      infoPlist: .extendingDefault(
        with: [
          "CFBundleDisplayName": "런콤비",
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
          ],
        ]
      ),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [
        .project(
          target: "FeatureMain",
          path: .relativeToRoot("Projects/Feature/Main")
        )
      ]
    )
  ]
)


