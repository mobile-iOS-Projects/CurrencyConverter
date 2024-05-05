//
//  Project+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Weiss, Alexander on 11.01.22.
//

import ProjectDescription

/// The base bundle id for all products in this workspace - can be accessed by any `Project.swift` file
public let workspaceBaseId = "com.ios.mobile.apps.CurrencyConverter"

extension Destinations {
    /// The destinations we support for the given set of platform
    public static func currencyConverterDestinations(for platforms: Set<Platform>) -> Destinations {
        var set: Destinations = []
        if platforms.contains(.iOS) {
            set.formUnion([.iPhone, .iPad])
        }

        if platforms.contains(.watchOS) {
            set.insert(.appleWatch)
        }

        if platforms.contains(.visionOS) {
            set.insert(.appleVision)
        }

        return set
    }
}

extension DeploymentTargets {
    // The deployment targets we support for the given set of platforms
    public static func currencyConverterDeploymentTargets(for platforms: Set<Platform>) -> DeploymentTargets {
        var iOS: String? = nil
        var watchOS: String? = nil
        var visionOS: String? = nil

        if platforms.contains(.iOS) {
            iOS = "17.0"
        }

        if platforms.contains(.watchOS) {
            watchOS = "10.0"
        }

        if platforms.contains(.visionOS) {
            visionOS = "1.1"
        }

        return .multiplatform(iOS: iOS, watchOS: watchOS, visionOS: visionOS)
    }
}
