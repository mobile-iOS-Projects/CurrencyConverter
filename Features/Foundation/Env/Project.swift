import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Feature
let project: Project = .microFeatureProject(
    name: "Env",
    type: .foundation,
    targets: [
        .implementation(
        ),
        .interface(
            dependencies: [
            ]
        )
    ],
    platforms: [.iOS],
    disableTargetSetValidation: true
)
