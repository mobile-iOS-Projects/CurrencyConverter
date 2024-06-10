import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .microFeatureProject(
    name: "Conversion",
    type: .product,
    targets: [
        .interface(),
        .implementation(
            dependencies: [
                .project(target: "CurrencyCoreUI", path: .relativeToRoot("Features/Foundation/CurrencyCoreUI"))
            ]
        ),
    ],
    platforms: [.iOS, .visionOS, .watchOS, .macOS]
)
