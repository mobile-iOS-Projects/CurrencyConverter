import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .microFeatureProject(
    name: "Networking",
    type: .foundation,
    targets: [
        .implementation(
            dependencies: [
                .project(target: "CurrencyCore", path: .relativeToRoot("Features/Foundation/CurrencyCore")),
            ]
        ),
    ],
    platforms: [.iOS, .visionOS, .watchOS, .macOS]
)
