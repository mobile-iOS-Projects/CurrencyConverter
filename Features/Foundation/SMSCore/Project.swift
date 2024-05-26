import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Feature
let project: Project = .microFeatureProject(
    name: "SMSCore",
    type: .foundation,
    targets: [
        .implementation(
        ),
    ],
    platforms: [.iOS, .visionOS, .watchOS, .macOS],
    disableTargetSetValidation: true
)
