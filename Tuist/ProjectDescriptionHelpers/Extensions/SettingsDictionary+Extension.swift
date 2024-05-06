//
//  SettingsDictionary+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation
import ProjectDescription

public extension SettingsDictionary {
    /// Sets "SUPPORTS_MACCATALYST" to "YES" or "NO"
    func supportsMacCatalyst(_ supported: Bool) -> SettingsDictionary {
        merging(["SUPPORTS_MACCATALYST": SettingValue(booleanLiteral: supported)])
    }

    /// Sets "APPLICATION_EXTENSION_API_ONLY" to "YES" or "NO"
    func applicationExtensionAPIOnly(_ flag: Bool) -> SettingsDictionary {
        merging(["APPLICATION_EXTENSION_API_ONLY": SettingValue(booleanLiteral: flag)])
    }

    /// Sets "CODE_SIGNING_ALLOWED" to "YES" or "NO"
    func codeSigningAllowed(_ flag: Bool) -> SettingsDictionary {
        merging(["CODE_SIGNING_ALLOWED": SettingValue(booleanLiteral: flag)])
    }

    /// Sets "CODE_SIGNING_REQUIRED" to "YES" or "NO"
    func codeSigningRequired(_ flag: Bool) -> SettingsDictionary {
        merging(["CODE_SIGNING_REQUIRED": SettingValue(booleanLiteral: flag)])
    }

    /// The base settings of a .framework target for CurrencyConverter
    ///
    /// Follwing properties are set:
    /// * CODE_SIGNING_ALLOWED: false
    /// * CODE_SIGNING_REQUIRED: false
    /// * ENABLE_BITCODE: false
    /// - Returns: A `SettingsDictionary` instance
    static func currencyConverterFrameworkBaseSettings() -> SettingsDictionary {
        .init()
            .codeSigningAllowed(false)
            .codeSigningRequired(false)
            .bitcodeEnabled(false)
    }
}
