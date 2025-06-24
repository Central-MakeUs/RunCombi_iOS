import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.make(
  name: "FeatureMain",
  targets: [
    .make(
      name: "FeatureMain",
      product: .staticLibrary,
      bundleId: "com.Combo.RunCombi",
      sources: ["Sources/**"],
      dependencies: [
        
      ]
    )
  ]
)
