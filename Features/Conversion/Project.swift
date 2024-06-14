import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .microFeatureProject(
    name: "Conversion",
    type: .product,
    targets: [
        .interface(),
        .implementation(
            dependencies: [
                .project(target: "Networking", path: .relativeToRoot("Features/Foundation/Networking")),
                .project(target: "CurrencyCore", path: .relativeToRoot("Features/Foundation/CurrencyCore")),
                .project(target: "CurrencyCoreUI", path: .relativeToRoot("Features/Foundation/CurrencyCoreUI")),
                .project(target: "Env", path: .relativeToRoot("Features/Foundation/Env")),
                .external(name: "Factory"),
                .external(name: "ComposableArchitecture"),
            ]
        ),
    ],
    platforms: [.iOS, .macOS, .visionOS]
)
