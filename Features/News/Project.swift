import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .microFeatureProject(
    name: "News",
    type: .product,
    targets: [
        .interface(),
        .implementation(
            dependencies: [
                .external(name: "ComposableArchitecture")
            ]
        ),
    ],
    platforms: [.iOS, .visionOS, .macOS]
)
