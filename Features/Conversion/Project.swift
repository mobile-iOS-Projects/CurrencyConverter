import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .microFeatureProject(
    name: "Conversion",
    type: .product,
    targets: [
        .interface(),
        .implementation(
            dependencies: [
                .project(target: "Networking", path: .relativeToRoot("Features/Foundation/Networking"))
            ]
        ),
    ],
    platforms: [.iOS, .watchOS, .macOS, .visionOS]
)
