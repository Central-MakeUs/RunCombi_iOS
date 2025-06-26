//
//  Project.swift
//  AppManifests
//
//  Created by 임경빈 on 6/27/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "LocalizableStringManager",
  targets: [
    .make(
      name: "LocalizableStringManager",
      product: .staticFramework,
      bundleId: "com.deepfine.LocalizableStringManager",
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [
        .project(
          target: "SharedUtility",
          path: .relativeToRoot("Projects/Shared/Utility")
        ),
      ]
    )
  ]
)

