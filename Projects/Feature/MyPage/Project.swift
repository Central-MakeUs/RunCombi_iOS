import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "FeatureMyPage",
  targets: [
    .make(
      name: "FeatureMyPage",
      product: .staticLibrary,
      bundleId: "com.Combo.FeatureMyPage",
      sources: ["Sources/**"],
      dependencies: [
        .project(
          target: "FeatureWatch",
          path: .relativeToRoot("Projects/Feature/Watch")
        ),
        .project(
          target: "DomainMyPage",
          path: .relativeToRoot("Projects/Domain/MyPage")
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
