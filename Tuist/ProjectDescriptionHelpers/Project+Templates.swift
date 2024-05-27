//
//  Project+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by Sergey Runovich on 6.05.24.
//

import ProjectDescription

/// The base bundle id for all products in this workspace - can be accessed by any `Project.swift` file
public let workspaceBaseId = "com.currency.converter.mobile.apps"

public extension Destinations {
    /// The destinations we support for the given set of platform
    static func smsDestinations(for platforms: Set<Platform>) -> Destinations {
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
        
        if platforms.contains(.macOS) {
            set.insert(.macCatalyst)
        }

        return set
    }
}

public extension DeploymentTargets {
    // The deployment targets we support for the given set of platforms
    static func smsDeploymentTargets(for platforms: Set<Platform>) -> DeploymentTargets {
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

        return .multiplatform(
            iOS: iOS,
            watchOS: watchOS,
            visionOS: visionOS
        )
    }
}
