import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "FeatureSplash",
  targets: [
    .make(
      name: "FeatureSplash",
      product: .staticLibrary,
      bundleId: "com.Combo.FeatureSplash",
      sources: ["Sources/**"],
      dependencies: [
        .project(
          target: "FeatureWatch",
          path: .relativeToRoot("Projects/Feature/Watch")
        ),
        .project(
          target: "SharedUtility",
          path: .relativeToRoot("Projects/Shared/Utility")
        ),
        .project(
          target: "UserInterface",
          path: .relativeToRoot("Projects/DesignSystem/UserInterface")
        ),
      ]
    )
  ]
)
