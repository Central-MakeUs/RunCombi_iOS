//
//  Project.swift
//  AppManifests
//
//  Created by 임경빈 on 6/26/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "UserInterface",
  packages: [.local(path: .relativeToCurrentFile("ResourceKit"))],
  targets: [
    .make(
      name: "UserInterface",
      product: .staticFramework,
      bundleId: "com.deepfine.UserInterface",
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [
//        .project(
//          target: "LocalizableStringManager",
//          path: .relativeToRoot("Projects/DesignSystem/LocalizableStringManager")
//        ),
        .project(
          target: "SharedUtility",
          path: .relativeToRoot("Projects/Shared/Utility")
        ),
        .package(product: "ResourceKit")
      ]
    )
  ]
)
