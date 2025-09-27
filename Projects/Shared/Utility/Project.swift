//
//  Project.swift
//  AppManifests
//
//  Created by 임경빈 on 6/26/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "SharedUtility",
  targets: [
    .make(
      name: "SharedUtility",
      destinations: [.appleWatch, .iPhone],
      product: .framework,
      bundleId: "com.Combo.SharedUtility",
      deploymentTargets: .multiplatform(iOS: "17.0.0", watchOS: "9.0"),
      sources: ["Sources/**"],
      dependencies: [
        .external(name: "Dependencies"),
        .external(name: "KeychainAccess"),
      ]
    )
  ]
)
