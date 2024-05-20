// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let frameworkBaseSettings: [String: SettingValue] = .currencyConverterFrameworkBaseSettings()

    let packageSettings = PackageSettings(
        productTypes: [ // Convert 3rd party frameworks into dynamic frameworks
            "Factory": .framework
        ],
        baseSettings: .settings(
            base: [:],
            configurations: [.debug(name: "Development")],
            defaultSettings: .recommended
        ),
        targetSettings: [
            "Factory": frameworkBaseSettings.applicationExtensionAPIOnly(true),
        ]
    )
#endif

let package = Package(
    name: "CurrencyConverterDependencies",
    dependencies: [
        // true 3rd Party Dependencies
        .package(url: "https://github.com/hmlongco/Factory", from: "2.3.2")
    ]
)
