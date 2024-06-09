import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .microFeatureProject(
    name: "Conversion",
    type: .product,
    targets: [
        .interface(),
        .implementation(
            dependencies: [
            ]
        ),
    ],
    platforms: [.iOS, .visionOS, .watchOS, .macOS]
)
