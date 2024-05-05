//
//  Set+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Steinmetz, Conrad on 24.11.22.
//

import Foundation
import ProjectDescription

extension Set<Platform> {
    /// Validates the given set of `Platform`s based on the MicroFeature guidelines
    /// - Returns: A ValidationResult
    func validate() -> ValidationResult {
        guard !self.contains(.macOS) else {
            return .failed(reason: "Not available for macOS")
        }

        guard !self.contains(.tvOS) else {
            return .failed(reason: "Not available for tvOS")
        }

        return .success
    }
}
