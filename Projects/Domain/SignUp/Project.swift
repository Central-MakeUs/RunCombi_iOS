import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "DomainSignUp",
  targets: [
    .make(
      name: "DomainSignUp",
      product: .staticLibrary,
      bundleId: "com.Combo.DomainSignUp",
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
