//
//  Environment+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Sergey Runovich on 6.05.24.
//

import ProjectDescription

public extension Environment {
    /// Maps the passed environment variable `TUIST_INCLUDE_BUILD_PHASE_SCRIPTS` into a
    /// `Bool` which can be used to determine whether Build Phase Scripts should be included or omitted.
    ///
    /// - Returns: `Bool` whether build phase scripts should be included or omitted. Defaults to `true`
    static func isScriptsIncluded() -> Bool {
        return Environment.includeBuildPhaseScripts.getBoolean(default: true)
    }
}
