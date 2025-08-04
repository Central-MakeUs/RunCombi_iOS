import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "FeatureCalendar",
  targets: [
    .make(
      name: "FeatureCalendar",
      product: .staticLibrary,
      bundleId: "com.Combo.FeatureCalendar",
      sources: ["Sources/**"],
      dependencies: [
        .project(
          target: "DomainCalendar",
          path: .relativeToRoot("Projects/Domain/Calendar")
        ),
        .project(
          target: "FeatureRecord",
          path: .relativeToRoot("Projects/Feature/Record")
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
