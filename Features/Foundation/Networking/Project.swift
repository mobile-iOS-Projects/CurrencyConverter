import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .microFeatureProject(
    name: "Networking",
    type: .foundation,
    targets: [
        .implementation(
            dependencies: [
                .project(target: "SMSCore", path: .relativeToRoot("Features/Foundation/SMSCore")),
            ]
        ),
    ],
    platforms: [.iOS, .visionOS, .watchOS, .macOS]
)
