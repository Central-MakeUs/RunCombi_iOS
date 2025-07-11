import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "FeatureSignUp",
  targets: [
    .make(
      name: "FeatureSignUp",
      product: .staticLibrary,
      bundleId: "com.Combo.FeatureSignUp",
      sources: ["Sources/**"],
      dependencies: [
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
