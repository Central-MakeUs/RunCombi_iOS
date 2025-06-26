//
//  Project.swift
//  AppManifests
//
//  Created by 임경빈 on 6/26/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "CoreNetwork",
  targets: [
    .make(
      name: "CoreNetwork",
      product: .staticLibrary,
      bundleId: "com.Combo.CoreNetwork",
      sources: ["Sources/**"],
      dependencies: [
        .external(name: "Alamofire"),
        .project(
          target: "SharedUtility",
          path: .relativeToRoot("Projects/Shared/Utility")
        ),
      ]
    )
  ]
)

