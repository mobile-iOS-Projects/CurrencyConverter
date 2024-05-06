import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .microFeatureProject(
    name: "Networking",
    type: .foundation,
    targets: [
        .interface(),
        .implementation(
            dependencies: [
            ]
        ),
    ],
    platforms: [.iOS]
)
