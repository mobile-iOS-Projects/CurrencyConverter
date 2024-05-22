import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Feature
let project: Project = .microFeatureProject(
    name: "SwiftData",
    type: .foundation,
    targets: [
        .implementation(
        ),
    ],
    platforms: [.iOS],
    disableTargetSetValidation: true
)
