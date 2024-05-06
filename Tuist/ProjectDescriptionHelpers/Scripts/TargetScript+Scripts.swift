//
//  TargetScript+Scripts.swift
//  ProjectDescriptionHelpers
//
//  Created by Weiss, Alexander on 23.01.22.
//

import ProjectDescription

// MARK: - swiftformat

public extension TargetScript {
    /// Create a `.post` script action for swiftformat based on the current feature type
    ///
    /// - Parameters
    ///   - featureType: The type of feature for which the swiftformat script should be added
    /// - Returns: A `.post` TargetScript
    static func swiftformatScript(
        for _: MicroFeatureType,
        on featureTargetType: MicroFeatureTargetType
    ) -> TargetScript {
        var swiftformatSourcesPath: String? = switch featureTargetType {
        case .interface:
            "$SRCROOT/Interface"
        case .implementation:
            "$SRCROOT/Implementation"
        case .tests:
            "$SRCROOT/Tests"
        case .testSupporting:
            "$SRCROOT/TestSupporting"
        case .example:
            "$SRCROOT/Example"
        }

        // Sanity check
        guard let swiftformatSourcesPath else {
            fatalError("SwiftFormat sources path could not be determined")
        }

        return .swiftformatScript(sourcesPath: swiftformatSourcesPath)
    }

    /// Create a `.post` script action for swiftformat
    ///
    /// - Parameters
    ///   - sourcesPath: The path to the sources from the current working directory
    /// - Returns: A `.post` TargetScript
    static func swiftformatScript(sourcesPath: String) -> TargetScript {
        return .post(
            path: .relativeToRoot("Scripts/swiftformat.sh"),
            arguments: [
                sourcesPath, // the sources to lint (the sources of the target to which this script is added)
            ],
            name: "SwiftFormat",
            basedOnDependencyAnalysis: false // Run script everytime
        )
    }
}

// MARK: - Swiftlint

public extension TargetScript {
    /// Create a `.post` script action for SwiftLint based on the current feature type
    ///
    /// - Parameters
    ///   - featureType: The type of feature for which the SwiftLint script should be added
    /// - Returns: A `.post` TargetScript
    static func swiftLintScript(
        for _: MicroFeatureType,
        on featureTargetType: MicroFeatureTargetType
    ) -> TargetScript {
        var swiftLintSourcesPath: String? = switch featureTargetType {
        case .interface:
            "$SRCROOT/Interface"
        case .implementation:
            "$SRCROOT/Implementation"
        case .tests:
            "$SRCROOT/Tests"
        case .testSupporting:
            "$SRCROOT/TestSupporting"
        case .example:
            "$SRCROOT/Example"
        }

        // Sanity check
        guard let swiftLintSourcesPath else {
            fatalError("SwiftLint sources path could not be determined")
        }

        return .swiftLintScript(sourcesPath: swiftLintSourcesPath)
    }

    /// Create a `.post` script action for SwiftLint
    ///
    /// - Parameters
    ///   - configPath: The path to the configuration file of swiftlint from the working directory of the current manifest file
    ///   - sourcesPath: The path to the sources from the current working directory
    /// - Returns: A `.post` TargetScript
    static func swiftLintScript(sourcesPath: String) -> TargetScript {
        return .post(
            path: .relativeToRoot("Scripts/swiftlint.sh"),
            arguments: [
                sourcesPath, // the sources to lint (the sources of the target to which this script is added)
            ],
            name: "SwiftLint",
            basedOnDependencyAnalysis: false // Run script everytime
        )
    }
}

// MARK: - Highlight Todo

public extension TargetScript {
    /// Create a `.pre` script action for highlighting todos in Xcode
    ///
    /// - Parameters
    ///   - featureType: The type of feature for which the Highlight todo script should be added
    /// - Returns: A `.post` TargetScript
    static func highlightTodosScript(
        for _: MicroFeatureType,
        on featureTargetType: MicroFeatureTargetType
    ) -> TargetScript {
        var sourcesPath: String? = switch featureTargetType {
        case .interface:
            "$SRCROOT/Interface"
        case .implementation:
            "$SRCROOT/Implementation"
        case .tests:
            "$SRCROOT/Tests"
        case .testSupporting:
            "$SRCROOT/TestSupporting"
        case .example:
            "$SRCROOT/Example"
        }

        // Sanity check
        guard let sourcesPath else {
            fatalError("Highlight todo sources path could not be determined")
        }

        return .highlightTodosScript(sourcesPath: sourcesPath)
    }

    /// Create a `.pre` script action for highlighting todos in Xcode
    ///
    /// - Parameters:
    ///   - sourcesPath: The path to the sources from the current working directory
    /// - Returns: A `.pre` TargetScript
    static func highlightTodosScript(sourcesPath: String) -> TargetScript {
        return .pre(
            path: .relativeToRoot("Scripts/highlight_todos.sh"),
            arguments: [
                sourcesPath,
            ],
            name: "Highlight Todos",
            basedOnDependencyAnalysis: false // Run script everytime
        )
    }
}
