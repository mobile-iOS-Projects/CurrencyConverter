import ProjectDescription

let project = Project(
    name: "CurrencyConverter",
    targets: [
        .target(
            name: "CurrencyConverter",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.CurrencyConverter",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["CurrencyConverter/Sources/**"],
            resources: ["CurrencyConverter/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "CurrencyConverterTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CurrencyConverterTests",
            infoPlist: .default,
            sources: ["CurrencyConverter/Tests/**"],
            resources: [],
            dependencies: [.target(name: "CurrencyConverter")]
        ),
    ]
)
