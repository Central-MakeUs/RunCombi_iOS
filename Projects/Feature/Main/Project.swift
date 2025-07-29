import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "FeatureMain",
  targets: [
    .make(
      name: "FeatureMain",
      product: .staticLibrary,
      bundleId: "com.Combo.FeatureMain",
      sources: ["Sources/**"],
      dependencies: [
        .project(
          target: "FeatureCalendar",
          path: .relativeToRoot("Projects/Feature/Calendar")
        ),
        .project(
          target: "FeatureExercise",
          path: .relativeToRoot("Projects/Feature/Exercise")
        ),
        .project(
          target: "FeatureMyPage",
          path: .relativeToRoot("Projects/Feature/MyPage")
        ),
        .project(
          target: "SharedUtility",
          path: .relativeToRoot("Projects/Shared/Utility")
        ),
        .project(
          target: "UserInterface",
          path: .relativeToRoot("Projects/DesignSystem/UserInterface")
        ),
        .project(
          target: "CoreNetwork",
          path: .relativeToRoot("Projects/Core/Network")
        )
      ]
    )
  ]
)
