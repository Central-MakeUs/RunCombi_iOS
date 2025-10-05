import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "DomainLogin",
  targets: [
    .make(
      name: "DomainLogin",
      destinations: [.appleWatch, .iPhone],
      product: .staticLibrary,
      bundleId: "com.Combo.DomainLogin",
      deploymentTargets: .multiplatform(iOS: "17.0.0", watchOS: "9.0"),
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
