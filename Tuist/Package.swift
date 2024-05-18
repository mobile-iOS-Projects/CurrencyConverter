// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let frameworkBaseSettings: [String: SettingValue] = .currencyConverterFrameworkBaseSettings()

    let packageSettings = PackageSettings(
        productTypes: [
            "Factory": .framework
        ],
        baseSettings: .settings(
            base: [:],
            configurations: [.debug(name: "Development")],
            defaultSettings: .recommended
        ),
        targetSettings: [:]
    )
#endif

let package = Package(
    name: "CurrencyConverterDependencies",
    dependencies: [
        .package(url: "https://github.com/hmlongco/Factory", from: "2.3.2")
    ]
)
