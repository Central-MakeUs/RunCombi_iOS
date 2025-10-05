import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "FeatureWatch",
  targets: [
    .make(
      name: "FeatureWatch",
      product: .staticLibrary,
      bundleId: "com.Combo.FeatureWatch",
      sources: ["Sources/**"],
      dependencies: [
        .project(
          target: "SharedUtility",
          path: .relativeToRoot("Projects/Shared/Utility")
        ),
      ]
    )
  ]
)
