import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "DomainLogin",
  targets: [
    .make(
      name: "DomainLogin",
      product: .staticLibrary,
      bundleId: "com.Combo.DomainLogin",
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
