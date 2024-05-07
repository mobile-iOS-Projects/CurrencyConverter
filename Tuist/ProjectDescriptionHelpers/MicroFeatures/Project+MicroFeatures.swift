//
//  Project+MicroFeatures.swift
//  ProjectDescriptionHelpers
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation
import ProjectDescription

public extension Project {
    /// Generate a project that conforms the MicroFeature guidelines
    ///
    /// - Parameters:
    ///   - name: Name of the project
    ///   - type: Type of the MicroFeature project
    ///   - targets: Which MicroFeature project targets should be inside
    ///   - platforms: The platforms that are supported by the micro feature targets.
    ///   - useExampleProjectAsTestHost: Flag to set the example project as the test host target. Requires an `.example` target to
    /// be present in `targets`
    ///   - disableTargetSetValidation: __USE WITH CAUTION!__ Flag to disable the target set validation. Use at your own risk as
    /// this can break the project generation. Useful for core features that do not follow the micro feature rules that strictly.
    ///   - additionalTargets: Optional array of additional targets that should be added to this project. __NO VALIDATION__ or any
    /// other convience additions are addition to these targets. Developers are responsible for taking care of the correct
    /// configuration of these targets in the current context
    ///   - additionalSchemes: Optional array of additional schemes that should be added to this project.
    ///   - shouldSupportAppExtensions: Flag to tell the generator that `Interface` and `Implementation` targets of this feature
    /// support app extension API
    /// - Returns: A project that conforms to the MicroFeature guidelines
    static func microFeatureProject(
        name: String,
        type: MicroFeatureType,
        targets: Set<MicroFeatureTarget>,
        platforms: Set<Platform> = [.iOS],
        useExampleProjectAsTestHost: Bool = false,
        disableTargetSetValidation: Bool = false,
        additionalTargets: [Target] = [],
        additionalSchemes: [Scheme] = [],
        shouldSupportAppExtensions: Bool = false,
        file: String = #file
    ) -> Project {
        // Target validation step
        if !disableTargetSetValidation,
           case let .failed(targetValidationFailedReason) = targets.validate()
        {
            fatalError(
                "\n\nError for project \(name) - \(targetValidationFailedReason ?? "Set of MicroFeature targets is invalid")\n"
            )
        }

        // Platform validation step
        if case let .failed(platformValidationFailedReason) = platforms.validate() {
            fatalError(
                "\n\nError for project \(name) - \(platformValidationFailedReason ?? "Set of MicroFeature platforms is invalid")\n"
            )
        }

        // Directory name validation
        let manifestPathURL = URL(fileURLWithPath: String(file))
        if manifestPathURL.deletingLastPathComponent().lastPathComponent != name {
            fatalError(
                "\n\nPlease name your feature directory exactly the same like your features project name \(name) != \(manifestPathURL.deletingLastPathComponent().lastPathComponent)\n"
            )
        }

        // Base project properties
        let projectName = name
        let moduleBaseId = "\(workspaceBaseId).\(name.camelCased)"

        // Generate project targets and schemes based on provided set of micro feature targets
        var projectTargets: [Target] = []
        var projectBuildTargets: [TargetReference] = []
        var projectTestTargets: [TestableTarget] = []
        var projectRunTarget: TargetReference?

        let frameworkBaseSettings: [String: SettingValue] = .currencyConverterFrameworkBaseSettings()

        let developmentConfiguration: Configuration = .debug(
            name: "Development",
            settings: SettingsDictionary(),
            xcconfig: .relativeToRoot("Shared/Configurations/FeatureFlagsDevelopment.xcconfig")
        )

        let enterpriseConfiguration: Configuration = .release(
            name: "Enterprise",
            settings: SettingsDictionary(),
            xcconfig: .relativeToRoot("Shared/Configurations/FeatureFlagsEnterprise.xcconfig")
        )

        // MARK: - Interface Target

        if let interfaceTarget = targets.interfaceTarget {
            // Create an interface target for each platform specified
            let interfaceTarget: Target = .target(
                name: "\(projectName)API",
                destinations: .currencyConverterDestinations(for: platforms),
                product: .framework,
                productName: "\(projectName)API",
                bundleId: "\(moduleBaseId).api",
                deploymentTargets: .currencyConverterDeploymentTargets(for: platforms),
                infoPlist: .default,
                sources: ["Interface/Sources/**/*.swift"],
                resources: ["Interface/Resources/**/*"],
                scripts: Environment.isScriptsIncluded() ? [
                    .swiftLintScript(for: type, on: .interface),
                    .highlightTodosScript(for: type, on: .interface),
                ] + interfaceTarget.scripts : [],
                dependencies: interfaceTarget.dependencies,
                settings: .settings(
                    base: frameworkBaseSettings.applicationExtensionAPIOnly(shouldSupportAppExtensions),
                    configurations: [developmentConfiguration, enterpriseConfiguration],
                    defaultSettings: .recommended(excluding: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS"])
                )
            )

            // Add targets to the overall project
            projectTargets.append(interfaceTarget)

            // Add a reference of target to the project build targets
            projectBuildTargets.append("\(interfaceTarget.name)")
        }

        // MARK: - Implementation Target

        if let implementationTarget = targets.implementationTarget {
            // Create an implementation target for each platform specified
            let implementationTarget: Target = .target(
                name: "\(projectName)",
                destinations: .currencyConverterDestinations(for: platforms),
                product: .framework,
                productName: "\(projectName)",
                bundleId: moduleBaseId,
                deploymentTargets: .currencyConverterDeploymentTargets(for: platforms),
                infoPlist: .default,
                sources: [
                    "Implementation/Sources/**/*.swift",
                    .glob("Implementation/Resources/**/*.intentdefinition", codeGen: .public),
                ],
                resources: ["Implementation/Resources/**/*"],
                scripts: Environment.isScriptsIncluded() ? [
                    .swiftLintScript(for: type, on: .implementation),
                    .highlightTodosScript(for: type, on: .implementation)
                ] + implementationTarget.scripts : [],
                dependencies: [
                    implementationTarget.dependencies,
                    targets.containsInterface ? [.target(name: "\(projectName)API")] : [],
                ].joined(),
                settings: .settings(
                    base: frameworkBaseSettings.applicationExtensionAPIOnly(shouldSupportAppExtensions),
                    configurations: [developmentConfiguration],
                    defaultSettings: .recommended(excluding: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS"])
                )
            )

            // Add targets to the overall project
            projectTargets.append(implementationTarget)

            // Add a reference to the project build targets
            projectBuildTargets.append("\(implementationTarget.name)")
        }

        // MARK: - Tests Target

        if let testsTarget = targets.testsTarget {
            let testTarget: Target = .target(
                name: "\(projectName)Tests",
                destinations: .currencyConverterDestinations(for: platforms),
                product: .unitTests,
                bundleId: "\(moduleBaseId).tests",
                deploymentTargets: .currencyConverterDeploymentTargets(for: platforms),
                infoPlist: .default,
                sources: ["Tests/Sources/**/*.swift"],
                resources: ["Tests/Resources/**/*"],
                scripts: Environment.isScriptsIncluded() ? [
                    .swiftLintScript(for: type, on: .tests),
                    .highlightTodosScript(for: type, on: .tests)
                ] + testsTarget.scripts : [],
                dependencies: [
                    testsTarget.dependencies,
                    [.target(name: "\(projectName)")],
                    [
                        .xctest,
                    ],
                    targets.containsTestSupporting ? [.target(name: "\(projectName)TestSupporting")] : [],
                ].joined()
            )

            // Add targets to the overall project
            projectTargets.append(testTarget)

            // Add a reference to the project build targets
            projectTestTargets.append("\(testTarget.name)")
        }

        // MARK: - TestSupporting target

        if let testSupportingTarget = targets.testSupportingTarget {
            // Create an test supporting target for each platform specified
            let testSupportingTarget: Target = .target(
                name: "\(projectName)TestSupporting",
                destinations: .currencyConverterDestinations(for: platforms),
                product: .framework,
                productName: "\(projectName)TestSupporting",
                bundleId: "\(moduleBaseId).testsupporting",
                deploymentTargets: .currencyConverterDeploymentTargets(for: platforms),
                infoPlist: .default,
                sources: ["TestSupporting/Sources/**/*.swift"],
                resources: ["TestSupporting/Resources/**/*"],
                scripts: Environment.isScriptsIncluded() ? [
                    .swiftLintScript(for: type, on: .testSupporting),
                    .highlightTodosScript(for: type, on: .testSupporting)
                ] + testSupportingTarget.scripts : [], dependencies: [
                    testSupportingTarget.dependencies,
                    targets.containsInterface ? [.target(name: "\(projectName)API")] : [],
                ].joined(),
                settings: .settings(
                    base: frameworkBaseSettings,
                    configurations: [developmentConfiguration, enterpriseConfiguration],
                    defaultSettings: .recommended(excluding: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS"])
                )
            )

            // Add targets to the overall project
            projectTargets.append(testSupportingTarget)

            // Add a reference to the project build targets
            projectBuildTargets.append("\(testSupportingTarget.name)")
        }

        // MARK: - Example iOS target

        if let exampleTarget = targets.exampleTarget {
            let exampleTargetBaseSettings: [String: SettingValue] = [
                "PROVISIONING_PROFILE_SPECIFIER": "$(PROVISIONING_PROFILE_SPECIFIER_IOS_APP)",
            ]

            let developmentConfiguration: Configuration = .debug(
                name: "Development",
                settings: exampleTargetBaseSettings,
                xcconfig: .relativeToManifest("Example/SupportingFiles/Configurations/Development.xcconfig")
            )

            let enterpriseConfiguration: Configuration = .release(
                name: "Enterprise",
                settings: exampleTargetBaseSettings,
                xcconfig: .relativeToManifest("Example/SupportingFiles/Configurations/Enterprise.xcconfig")
            )

            projectTargets.append(
                .target(
                    name: "\(projectName)Example",
                    destinations: .currencyConverterDestinations(for: platforms.subtracting([.watchOS])),
                    product: .app,
                    bundleId: "\(moduleBaseId).example",
                    deploymentTargets: .currencyConverterDeploymentTargets(for: platforms.subtracting([.watchOS])),
                    infoPlist: .file(path: "Example/SupportingFiles/ExampleAppInfo.plist"),
                    sources: ["Example/Sources/**/*.swift"],
                    resources: ["Example/Resources/**/*"],
                    entitlements: .file(path: "Example/SupportingFiles/ExampleApp.entitlements"),
                    scripts: Environment.isScriptsIncluded() ? [
                        .swiftLintScript(for: type, on: .example),
                        .highlightTodosScript(for: type, on: .example)
                    ] + exampleTarget.scripts : [],
                    dependencies: [
                        [.target(name: projectName)],
                        targets.containsTestSupporting ? [.target(name: "\(projectName)TestSupporting")] : [],
                        exampleTarget.dependencies,
                    ].joined(),
                    settings: .settings(
                        configurations: [developmentConfiguration, enterpriseConfiguration],
                        defaultSettings: .recommended(excluding: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS"])
                    )
                )
            )
            projectRunTarget = "\(projectName)Example"
        }

        // MARK: - Custom Targets

        projectTargets.append(contentsOf: additionalTargets)

        // MARK: - Post Processing

        // MARK: Add iOS example app to unit tests if needed

        // Here we are adding the iOS example app as a test host
        // to the iOS unit test target if necessary
        if useExampleProjectAsTestHost,
           targets.containsExample,
           let testTargetIndex = projectTargets.firstIndex(where: {
               $0.name == "\(projectName)Tests"
           })
        {
            // Grab the test target
            var testTarget = projectTargets[testTargetIndex]

            // Copy and modify dependencies, adding the example iOS target
            var modifiedDependencies = testTarget.dependencies
            modifiedDependencies.append(.target(name: "\(projectName)Example"))

            // Change the target dependecies
            testTarget.dependencies = modifiedDependencies

            // Switch out original with changed target
            projectTargets[testTargetIndex] = testTarget
        }

        // MARK: Add watchOS example app to unit tests

        // Here we are adding the watchOS example app as a test host
        // to the watchOS unit test target if necessary
        if useExampleProjectAsTestHost,
           let watchOSExampleTarget = additionalTargets.first(where: {
               $0.destinations.contains(.appleWatch) && $0.product == .app
           }),
           let testTargetIndex = projectTargets.firstIndex(where: {
               $0.name == "\(projectName)Tests"
           })
        {
            // Grab the test target
            var testTarget = projectTargets[testTargetIndex]

            // Copy and modify dependencies, adding the example watchOS target
            var modifiedDependencies = testTarget.dependencies
            modifiedDependencies.append(.target(name: "\(watchOSExampleTarget.name)"))

            // Change the target dependecies
            testTarget.dependencies = modifiedDependencies

            // Switch out original with changed target
            projectTargets[testTargetIndex] = testTarget
        }

        // MARK: - Project Scheme

        let microFeatureScheme: Scheme = .scheme(
            name: "\(projectName)",
            shared: true,
            hidden: false,
            buildAction: .buildAction(targets: projectBuildTargets),
            testAction: .targets(
                projectTestTargets,
                configuration: "Development",
                options: .options(
                    language: .init(identifier: "en"),
                    region: "US",
                    coverage: true,
                    codeCoverageTargets: projectBuildTargets
                        + additionalTargets
                        .filter { $0.product != .unitTests && $0.product != .uiTests }
                        .map { .project(path: .relativeToManifest(""), target: $0.name) }
                )
            ),
            // swiftlint:disable:next force_unwrapping
            runAction: projectRunTarget != nil ? .runAction(configuration: "Development", executable: projectRunTarget!) : nil
        )

        // MARK: - Project Settings

        let baseProjectSettings = SettingsDictionary()
            .bitcodeEnabled(false)
            .swiftCompilationMode(.wholemodule)
            .supportsMacCatalyst(false)

        // MARK: - Project Initialization

        return Project(
            name: projectName,
            options: .options(
                automaticSchemesOptions: .disabled,
                defaultKnownRegions: ["de", "en", "es", "fi", "fr", "ja", "nl", "pt", "ru", "sv", "zh-Hans"],
                disableBundleAccessors: true,
                disableShowEnvironmentVarsInScriptPhases: false,
                disableSynthesizedResourceAccessors: true,
                textSettings: .currencyConverterTextSettings
            ),
            settings: .settings(
                base: baseProjectSettings,
                configurations: [developmentConfiguration, enterpriseConfiguration],
                defaultSettings: .recommended(excluding: ["SWIFT_ACTIVE_COMPILATION_CONDITIONS"])
            ),
            targets: projectTargets,
            schemes: [[microFeatureScheme], additionalSchemes].joined(),
            additionalFiles: [
                "README.md",
            ]
        )
    }
}
