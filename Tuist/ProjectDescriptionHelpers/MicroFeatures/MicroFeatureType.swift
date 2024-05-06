//
//  MicroFeatureType.swift
//  ProjectDescriptionHelpers
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation
import ProjectDescription

// MARK: - MicroFeatureType

/// Type of microfeatures
public enum MicroFeatureType {
    /// Foundation feature
    case foundation

    /// Product feature
    case product

    /// Executable feature
    case app
}

// MARK: - MicroFeatureTarget

public struct MicroFeatureTarget {
    let type: MicroFeatureTargetType
    let dependencies: [TargetDependency]
    let scripts: [TargetScript]

    private init(_ type: MicroFeatureTargetType, dependencies: [TargetDependency] = [], scripts: [TargetScript] = []) {
        self.type = type
        self.dependencies = dependencies
        self.scripts = scripts
    }

    public static func interface(dependencies: [TargetDependency] = [], scripts: [TargetScript] = []) -> Self {
        return .init(.interface, dependencies: dependencies, scripts: scripts)
    }

    public static func implementation(dependencies: [TargetDependency] = [], scripts: [TargetScript] = []) -> Self {
        return .init(.implementation, dependencies: dependencies, scripts: scripts)
    }

    public static func tests(dependencies: [TargetDependency] = [], scripts: [TargetScript] = []) -> Self {
        return .init(.tests, dependencies: dependencies, scripts: scripts)
    }

    public static func testSupporting(dependencies: [TargetDependency] = [], scripts: [TargetScript] = []) -> Self {
        return .init(.testSupporting, dependencies: dependencies, scripts: scripts)
    }

    public static func example(iOSDependencies: [TargetDependency] = [], scripts: [TargetScript] = []) -> Self {
        return .init(.example, dependencies: iOSDependencies, scripts: scripts)
    }
}

// MARK: Hashable

extension MicroFeatureTarget: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(type)
    }
}

// MARK: - MicroFeatureTargetType

/// Type of microfeature project targets within a micro feature
public enum MicroFeatureTargetType {
    /// Interfaces and data model of the feature which can be consumed by other features
    case interface

    /// Source code of the implementation of the feature. Should not be consumed by other features
    case implementation

    /// Unit and integration tests of the feature
    case tests

    /// Mocks and other helpers to test the feature
    case testSupporting

    /// Example application that showcases the feature in an real world environment
    case example
}

// MARK: -  Set Extension

extension Set<MicroFeatureTarget> {
    /// Validates the given set of `MicroFeatureTargetType`s based on the MicroFeature guidelines
    /// - Returns: A ValidationResult
    func validate() -> ValidationResult {
        let containsInterface = self.containsInterface
        let containsTests = containsTest
        let containsImplementation = self.containsImplementation
        let containsTestSupporting = self.containsTestSupporting
        let containsExample = self.containsExample

        if containsTests, !containsImplementation {
            return .failed(reason: "If tests are implemented, implementations needs to be available too")
        }

        if containsTestSupporting, !containsInterface {
            return .failed(reason: "If testSupporting mocks are implemented, interfaces needs to be available too")
        }

        if containsExample, !containsImplementation {
            return .failed(reason: "If example app is implemented, implementations needs to be available too")
        }

        if let exampleTarget = exampleTarget {
            if exampleTarget.dependencies.contains(.xctest)
                || testSupportingTarget?.dependencies.contains(.xctest) ?? false
                || implementationTarget?.dependencies.contains(.xctest) ?? false
            {
                return .failed(reason: "Example App is linked to XCTest - this will lead to a crash of the example app when run")
            }
        }
        return .success
    }

    /// Interface target, if present
    var interfaceTarget: MicroFeatureTarget? {
        first { $0.type == .interface }
    }

    /// Implementatiom target, if present
    var implementationTarget: MicroFeatureTarget? {
        first { $0.type == .implementation }
    }

    /// Test target, if present
    var testsTarget: MicroFeatureTarget? {
        first { $0.type == .tests }
    }

    /// Test supporting target, if present
    var testSupportingTarget: MicroFeatureTarget? {
        first { $0.type == .testSupporting }
    }

    /// Example app target, if present
    var exampleTarget: MicroFeatureTarget? {
        first { $0.type == .example }
    }

    var containsInterface: Bool {
        interfaceTarget != nil
    }

    var containsImplementation: Bool {
        implementationTarget != nil
    }

    var containsTest: Bool {
        testsTarget != nil
    }

    var containsTestSupporting: Bool {
        testSupportingTarget != nil
    }

    var containsExample: Bool {
        exampleTarget != nil
    }
}

// MARK: - ValidationResult

/// Represnts the result of a validation
///
/// * success: Validation was successful
/// * failed: Validation was not successful, optional reason provided
enum ValidationResult {
    case success
    case failed(reason: String?)
}
