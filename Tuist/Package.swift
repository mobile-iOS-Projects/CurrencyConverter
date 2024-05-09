// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import ProjectDescriptionHelpers

    let frameworkBaseSettings: [String: SettingValue] = .currencyConverterFrameworkBaseSettings()

    let packageSettings = PackageSettings(
        productTypes: [:],
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
    ]
)
