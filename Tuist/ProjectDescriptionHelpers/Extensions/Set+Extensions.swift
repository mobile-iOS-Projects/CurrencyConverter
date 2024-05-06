//
//  Set+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation
import ProjectDescription

extension Set<Platform> {
    /// Validates the given set of `Platform`s based on the MicroFeature guidelines
    /// - Returns: A ValidationResult
    func validate() -> ValidationResult {
        guard !contains(.macOS) else {
            return .failed(reason: "Not available for macOS")
        }

        guard !contains(.tvOS) else {
            return .failed(reason: "Not available for tvOS")
        }

        return .success
    }
}
