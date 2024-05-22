import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .microFeatureProject(
    name: "News",
    type: .product,
    targets: [
        .interface(),
        .implementation(
            dependencies: [
            ]
        ),
    ],
    platforms: [.iOS]
)
