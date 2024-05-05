import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .microFeatureProject(
    name: "Home",
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
