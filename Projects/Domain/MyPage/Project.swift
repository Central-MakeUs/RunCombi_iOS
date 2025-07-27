import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "DomainMyPage",
  targets: [
    .make(
      name: "DomainMyPage",
      product: .staticLibrary,
      bundleId: "com.Combo.DomainMyPage",
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
