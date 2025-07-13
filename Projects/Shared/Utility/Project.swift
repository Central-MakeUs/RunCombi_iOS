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
      product: .framework,
      bundleId: "com.Combo.SharedUtility",
      sources: ["Sources/**"],
      dependencies: [
        .external(name: "Dependencies"),
        .external(name: "KeychainAccess"),
      ]
    )
  ]
)
