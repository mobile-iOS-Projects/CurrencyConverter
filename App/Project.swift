import ProjectDescription
import ProjectDescriptionHelpers

let moduleBaseId = "\(workspaceBaseId)"

// MARK: - Scripts
let swiftformatScript: TargetScript = .swiftformatScript(
    sourcesPath: "$SRCROOT/Sources"
)

let swiftlintScript: TargetScript = .swiftLintScript(
    sourcesPath: "$SRCROOT/Sources"
)

let highlightTodosScript: TargetScript = .highlightTodosScript(
    sourcesPath: "$SRCROOT/Sources"
)

// MARK: - iOS

let developmentConfiguration: Configuration = .debug(
    name: "Development",
    settings: [:]
)

let appTarget: Target = .target(
    name: "App",
    destinations: .currencyDestinations(for: [.iOS]),
    product: .app,
    productName: "CurrencyConverter",
    bundleId: "$(APP_BUNDLE_ID_MAIN)",
    deploymentTargets: .currencyDeploymentTargets(for: [.iOS]),
    infoPlist: "SupportingFiles/Info.plist",
    sources: [
        "Sources/**/*.swift",
    ],
    resources: ["Resources/**/*"],
    entitlements: .file(path: "SupportingFiles/CurrencyConverter.entitlements"),
    scripts: Environment.isScriptsIncluded() ? [swiftformatScript, swiftlintScript, highlightTodosScript] : [],
    dependencies: [
        .project(target: "Conversion", path: .relativeToRoot("Features/Conversion")),
        .project(target: "News", path: .relativeToRoot("Features/News")),
        .project(target: "Settings", path: .relativeToRoot("Features/Settings")),
        .project(target: "Networking", path: .relativeToRoot("Features/Foundation/Networking")),
        .project(target: "CurrencyCore", path: .relativeToRoot("Features/Foundation/CurrencyCore")),
        .project(target: "CurrencyCoreUI", path: .relativeToRoot("Features/Foundation/CurrencyCoreUI")),
        .project(target: "SwiftData", path: .relativeToRoot("Features/Foundation/SwiftData")),
        .external(name: "Factory"),
        .external(name: "SwiftUIIntrospect"),
        
        .target(name: "watchOS", condition: .when([.ios])),
    ],
    settings: .settings(
        configurations: [developmentConfiguration],
        defaultSettings: .recommended(excluding: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS", "CODE_SIGN_IDENTITY"])
    )
)

let appUnitTestTarget: Target = .target(
    name: "AppUnitTests",
    destinations: .currencyDestinations(for: [.iOS]),
    product: .unitTests,
    bundleId: "\(moduleBaseId).tests",
    deploymentTargets: .currencyDeploymentTargets(for: [.iOS]),
    infoPlist: .default,
    sources: ["Tests/UnitTests/**/*.swift"],
    scripts: Environment.isScriptsIncluded() ? [
        .swiftformatScript(for: .app, on: .tests),
        .swiftLintScript(for: .app, on: .tests),
        .highlightTodosScript(for: .app, on: .tests),
    ] : [],
    dependencies: [
        .target(name: "App"),
        .xctest,
    ]
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
    archiveAction: .archiveAction(configuration: .configuration("Development"))
)

// MARK: - watchOS

// MARK: - watchOS App
let watchOSBaseSettings: [String: SettingValue] = [
    "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor"
]

let watchOSDevelopmentConfiguration: Configuration = .debug(
    name: "Development",
    settings: watchOSBaseSettings
)

let watchOSSwiftformatScript: TargetScript = .swiftformatScript(
    sourcesPath: "$SRCROOT/Extensions/watchOS"
)

let watchOSSwiftlintScript: TargetScript = .swiftLintScript(
    sourcesPath: "$SRCROOT/Extensions/watchOS"
)

let watchOSHighlightTodosScript: TargetScript = .highlightTodosScript(
    sourcesPath: "$SRCROOT/Extensions/watchOS"
)

let watchOSAppTarget: Target = .target(
    name: "watchOS",
    destinations: .currencyDestinations(for: [.watchOS]),
    product: .app,
    productName: "CurrencyConverter",
    bundleId: "$(APP_BUNDLE_ID_WATCH_OS)",
    deploymentTargets: .currencyDeploymentTargets(for: [.watchOS]),
    infoPlist: "Extensions/watchOS/SupportingFiles/Info.plist",
    sources: ["Extensions/watchOS/Sources/**/*.swift"],
    resources: ["Extensions/watchOS/Resources/**/*"],
    entitlements: .file(path: "Extensions/watchOS/SupportingFiles/CurrencyWatchApp.entitlements"),
    scripts: Environment.isScriptsIncluded() ? [watchOSSwiftformatScript, watchOSSwiftlintScript] : [],
    dependencies: [
        .project(target: "Conversion", path: .relativeToRoot("Features/Conversion")),
        .project(target: "News", path: .relativeToRoot("Features/News")),
        .project(target: "Settings", path: .relativeToRoot("Features/Settings")),
        .project(target: "Networking", path: .relativeToRoot("Features/Foundation/Networking")),
        .project(target: "CurrencyCore", path: .relativeToRoot("Features/Foundation/CurrencyCore")),
        .project(target: "CurrencyCoreUI", path: .relativeToRoot("Features/Foundation/CurrencyCoreUI")),
        .project(target: "SwiftData", path: .relativeToRoot("Features/Foundation/SwiftData")),
        .external(name: "Factory"),
    ],
    settings: .settings(
        base: [
            "GENERATE_INFOPLIST_FILE": false,
        ],
        configurations: [watchOSDevelopmentConfiguration],
        defaultSettings: .recommended(excluding: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS", "CODE_SIGN_IDENTITY"])
    )
)

let watchOSAppScheme: Scheme = .scheme(
    name: "CurrencyConverter - watchOS",
    shared: true,
    hidden: false,
    buildAction: .buildAction(targets: ["App", "watchOS"]),
    testAction: .targets(
        ["AppTests", "AppUITests"],
        configuration: "Development",
        options: .options(coverage: true, codeCoverageTargets: ["watchOS"])
    ),
    runAction: .runAction(configuration: "Development", executable: "watchOS"),
    archiveAction: .archiveAction(configuration: .configuration("Development"))
)

// MARK: - visionOS
let developmentConfigurationVisionOS: Configuration = .debug(
    name: "Development",
    settings: [:]
)

// visionOS
let visionOSAppTarget: Target = .target(
    name: "visionOS",
    destinations: .currencyDestinations(for: [.visionOS]),
    product: .app,
    productName: "CurrencyConverter",
    bundleId: "$(APP_BUNDLE_ID_VISIONOS)",
    deploymentTargets: .currencyDeploymentTargets(for: [.visionOS]),
    infoPlist: "SupportingFiles/Info-visionOS.plist",
    sources: [
        "Sources/**/*.swift"
    ],
    resources: [
        "Resources/**/*"
    ],
    entitlements: .file(path: "SupportingFiles/CurrencyConverter.entitlements") ,
    scripts: Environment.isScriptsIncluded() ? [swiftformatScript, swiftlintScript, highlightTodosScript] : [],
    dependencies: [
        .project(target: "Conversion", path: .relativeToRoot("Features/Conversion")),
        .project(target: "News", path: .relativeToRoot("Features/News")),
        .project(target: "Settings", path: .relativeToRoot("Features/Settings")),
        .project(target: "Networking", path: .relativeToRoot("Features/Foundation/Networking")),
        .project(target: "CurrencyCore", path: .relativeToRoot("Features/Foundation/CurrencyCore")),
        .project(target: "CurrencyCoreUI", path: .relativeToRoot("Features/Foundation/CurrencyCoreUI")),
        .project(target: "SwiftData", path: .relativeToRoot("Features/Foundation/SwiftData")),
        .external(name: "Factory"),
    ],
    settings: .settings(
        base: ["LD_RUNPATH_SEARCH_PATHS": ["$(inherited)", "@executable_path/Frameworks"]],
        configurations: [
            developmentConfigurationVisionOS
        ],
        defaultSettings: .recommended(excluding: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS", "CODE_SIGN_IDENTITY"])
    )
)

let visionOSAppScheme: Scheme = .scheme(
    name: "CurrencyConverter - visionOS",
    shared: true,
    hidden: false,
    buildAction: .buildAction(targets: ["visionOS"]),
    testAction: .targets([], configuration: "Development", options: .options(coverage: true, codeCoverageTargets: ["visionOS"])),
    runAction: .runAction(configuration: "Development", executable: "visionOS"),
    archiveAction: .archiveAction(configuration: .configuration("Development"))
)

// MARK: - macOS

let developmentConfigurationMacOS: Configuration = .debug(
    name: "Development",
    settings: [:]
)

// macOS
let macOSAppTarget: Target = .target(
    name: "macOS",
    destinations: .currencyDestinations(for: [.macOS]),
    product: .app,
    productName: "CurrencyConverter",
    bundleId: "$(APP_BUNDLE_ID_MACOS)",
    deploymentTargets: .currencyDeploymentTargets(for: [.iOS]),
    infoPlist: .default,
    sources: [
        "Sources/**/*.swift"
    ],
    resources: [
        "Resources/**/*"
    ],
    scripts: Environment.isScriptsIncluded() ? [swiftformatScript, swiftlintScript, highlightTodosScript] : [],
    dependencies: [
        .project(target: "Conversion", path: .relativeToRoot("Features/Conversion")),
        .project(target: "News", path: .relativeToRoot("Features/News")),
        .project(target: "Settings", path: .relativeToRoot("Features/Settings")),
        .project(target: "Networking", path: .relativeToRoot("Features/Foundation/Networking")),
        .external(name: "Factory"),
        .external(name: "SwiftUIIntrospect"),
    ],
    settings: .settings(
        configurations: [
            developmentConfigurationMacOS
        ],
        defaultSettings: .recommended(excluding: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS", "CODE_SIGN_IDENTITY"])
    )
)

let macOSAppScheme: Scheme = .scheme(
    name: "CurrencyConverter - macOS",
    shared: true,
    hidden: false,
    buildAction: .buildAction(targets: ["macOS"]),
    testAction: .targets([], configuration: "Development", options: .options(coverage: true, codeCoverageTargets: ["macOS"])),
    runAction: .runAction(configuration: "Development", executable: "macOS"),
    archiveAction: .archiveAction(configuration: .configuration("Development"))
)

let project = Project(
    name: "App",
    options: .options(
        automaticSchemesOptions: .disabled,
        disableBundleAccessors: true,
        disableShowEnvironmentVarsInScriptPhases: false,
        disableSynthesizedResourceAccessors: true,
        textSettings: .currencyTextSettings
    ),
    settings: .settings(configurations: [
        .debug(
            name: "Development",
            settings: [:],
            xcconfig: .relativeToManifest("SupportingFiles/Configurations/Development.xcconfig")
        ),
    ]),
    targets: [
        appTarget,
        appUnitTestTarget,
        watchOSAppTarget,
        visionOSAppTarget,
        macOSAppTarget
    ],
    schemes: [
        appScheme,
        watchOSAppScheme,
        visionOSAppScheme,
        macOSAppScheme
    ],
    additionalFiles: [
        "README.md",
        .folderReference(path: .relativeToRoot("./Shared/Configurations")),
    ]
)
