import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "FeatureExercise",
  targets: [
    .make(
      name: "FeatureExercise",
      product: .staticLibrary,
      bundleId: "com.Combo.FeatureExercise",
      sources: ["Sources/**"],
      dependencies: [
        .external(name: "GoogleMaps"),
        .project(
          target: "DomainExercise",
          path: .relativeToRoot("Projects/Domain/Exercise")
        ),
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
