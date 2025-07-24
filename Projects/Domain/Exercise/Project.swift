import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "DomainExercise",
  targets: [
    .make(
      name: "DomainExercise",
      product: .staticLibrary,
      bundleId: "com.Combo.DomainExercise",
      sources: ["Sources/**"],
      dependencies: [
        .project(
          target: "SharedUtility",
          path: .relativeToRoot("Projects/Shared/Utility")
        ),
        .project(
          target: "CoreNetwork",
          path: .relativeToRoot("Projects/Core/Network")
        )
      ]
    )
  ]
)
