import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Feature
let project: Project = .microFeatureProject(
    name: "SMSCoreUI",
    type: .foundation,
    targets: [
        .implementation(
        ),
    ],
    platforms: [.iOS],
    disableTargetSetValidation: true
)
