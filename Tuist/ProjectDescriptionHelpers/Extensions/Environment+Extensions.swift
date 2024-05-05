//
//  Environment+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Schmitt, Frank on 14.02.24.
//

import ProjectDescription

extension Environment {
    /// Maps the passed environment variable `TUIST_INCLUDE_BUILD_PHASE_SCRIPTS` into a
    /// `Bool` which can be used to determine whether Build Phase Scripts should be included or omitted.
    ///
    /// - Returns: `Bool` whether build phase scripts should be included or omitted. Defaults to `true`
    public static func isScriptsIncluded() -> Bool {
        return Environment.includeBuildPhaseScripts.getBoolean(default: true)
    }
}
