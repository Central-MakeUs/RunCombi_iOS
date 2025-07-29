import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "DomainCalendar",
  targets: [
    .make(
      name: "DomainCalendar",
      product: .staticLibrary,
      bundleId: "com.Combo.DomainCalendar",
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
