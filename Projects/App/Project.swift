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
    "DEVELOPMENT_TEAM": "\(AppEnvironment.developmentTeam)"
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
      infoPlist: AppEnvironment.infoPlist,
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [
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


