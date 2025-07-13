import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "FeatureLogin",
  targets: [
    .make(
      name: "FeatureLogin",
      product: .staticLibrary,
      bundleId: "com.Combo.FeatureLogin",
      sources: ["Sources/**"],
      dependencies: [
        .external(name: "KakaoSDK"),
        .project(
          target: "FeatureSignUp",
          path: .relativeToRoot("Projects/Feature/SignUp")
        ),
        .project(
          target: "DomainLogin",
          path: .relativeToRoot("Projects/Domain/Login")
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
