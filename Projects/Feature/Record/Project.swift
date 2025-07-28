import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "FeatureRecord",
  targets: [
    .make(
      name: "FeatureRecord",
      product: .staticLibrary,
      bundleId: "com.Combo.FeatureRecord",
      sources: ["Sources/**"],
      dependencies: [
        .external(name: "GoogleMaps"),
        .project(
          target: "SharedUtility",
          path: .relativeToRoot("Projects/Shared/Utility")
        ),
        .project(
          target: "UserInterface",
          path: .relativeToRoot("Projects/DesignSystem/UserInterface")
        )
      ]
    )
  ]
)
