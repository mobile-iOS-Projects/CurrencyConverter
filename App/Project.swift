import ProjectDescription
import ProjectDescriptionHelpers

let moduleBaseId = "\(workspaceBaseId)"

// MARK: - Scripts
let swiftlintScript: TargetScript = .swiftLintScript(
    sourcesPath: "$SRCROOT/Sources"
)

let highlightTodosScript: TargetScript = .highlightTodosScript(
    sourcesPath: "$SRCROOT/Sources"
)

// MARK: - iOS
let iOSBaseSettings: [String: SettingValue] = [
    "PROVISIONING_PROFILE_SPECIFIER": "$(PROVISIONING_PROFILE_SPECIFIER_MAIN)",
]

let developmentConfiguration: Configuration = .debug(
    name: "Development",
    settings: iOSBaseSettings
)

let enterpriseConfiguration: Configuration = .release(
    name: "Enterprise",
    settings: iOSBaseSettings
)

let appTarget: Target = .target(
    name: "App",
    destinations: .currencyConverterDestinations(for: [.iOS]),
    product: .app,
    productName: "CurrencyConverter",
    bundleId: "$(APP_BUNDLE_ID_MAIN)",
    deploymentTargets: .currencyConverterDeploymentTargets(for: [.iOS]),
    infoPlist: .extendingDefault(
        with: [
            "UILaunchStoryboardName": "LaunchScreen.storyboard",
        ]
    ),
    sources: [
        "Sources/**/*.swift",
    ],
    resources: ["Resources/**/*"],
    scripts: Environment.isScriptsIncluded() ? [swiftlintScript, highlightTodosScript] : [],
    dependencies: [
        .project(target: "Home", path: .relativeToRoot("Features/Home")),
    ],
    settings: .settings(
        configurations: [developmentConfiguration],
        defaultSettings: .recommended(excluding: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS", "CODE_SIGN_IDENTITY"])
    )
)

let appScheme: Scheme = .scheme(
    name: "CurrencyConverter",
    shared: true,
    hidden: false,
    buildAction: .buildAction(targets: ["App"]),
    testAction: .targets(
        ["AppTests", "AppUITests"],
        configuration: "Development",
        options: .options(coverage: true, codeCoverageTargets: ["App"])
    ),
    runAction: .runAction(configuration: "Development", executable: "App"),
    archiveAction: .archiveAction(configuration: .configuration("Enterprise"))
)

let project = Project(
    name: "App",
    options: .options(
        automaticSchemesOptions: .disabled,
        disableBundleAccessors: true,
        disableShowEnvironmentVarsInScriptPhases: false,
        disableSynthesizedResourceAccessors: true,
        textSettings: .currencyConverterTextSettings
    ),
    settings: .settings(configurations: [
        .debug(
            name: "Development",
            settings: [:],
            xcconfig: .relativeToManifest("SupportingFiles/Configurations/Development.xcconfig")
        ),
        .release(
            name: "Enterprise",
            settings: [:],
            xcconfig: .relativeToManifest("SupportingFiles/Configurations/Enterprise.xcconfig")
        ),
    ]),
    targets: [
        appTarget,
    ],
    schemes: [
        appScheme,
    ],
    additionalFiles: [
        "README.md",
        .folderReference(path: .relativeToRoot("./Shared/Configurations")),
    ]
)
