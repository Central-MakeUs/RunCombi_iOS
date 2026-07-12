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
        // KakaoSDK 우산 제품 대신 사용하는 모듈만 의존
        // (미사용 KakaoSDKFriendCore xcframework가 Release 빌드에서 중복 태스크 에러 유발)
        .external(name: "KakaoSDKCommon"),
        .external(name: "KakaoSDKAuth"),
        .external(name: "KakaoSDKUser"),
        .project(
          target: "FeatureWatch",
          path: .relativeToRoot("Projects/Feature/Watch")
        ),
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
