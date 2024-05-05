//
//  SettingsDictionary+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by Weiss, Alexander on 15.02.22.
//

import Foundation
import ProjectDescription

extension SettingsDictionary {
    /// Sets "SUPPORTS_MACCATALYST" to "YES" or "NO"
    public func supportsMacCatalyst(_ supported: Bool) -> SettingsDictionary {
        merging(["SUPPORTS_MACCATALYST": SettingValue(booleanLiteral: supported)])
    }

    /// Sets "APPLICATION_EXTENSION_API_ONLY" to "YES" or "NO"
    public func applicationExtensionAPIOnly(_ flag: Bool) -> SettingsDictionary {
        merging(["APPLICATION_EXTENSION_API_ONLY": SettingValue(booleanLiteral: flag)])
    }

    /// Sets "CODE_SIGNING_ALLOWED" to "YES" or "NO"
    public func codeSigningAllowed(_ flag: Bool) -> SettingsDictionary {
        merging(["CODE_SIGNING_ALLOWED": SettingValue(booleanLiteral: flag)])
    }

    /// Sets "CODE_SIGNING_REQUIRED" to "YES" or "NO"
    public func codeSigningRequired(_ flag: Bool) -> SettingsDictionary {
        merging(["CODE_SIGNING_REQUIRED": SettingValue(booleanLiteral: flag)])
    }

    /// The base settings of a .framework target for CurrencyConverter
    ///
    /// Follwing properties are set:
    /// * CODE_SIGNING_ALLOWED: false
    /// * CODE_SIGNING_REQUIRED: false
    /// * ENABLE_BITCODE: false
    /// - Returns: A `SettingsDictionary` instance
    public static func currencyConverterFrameworkBaseSettings() -> SettingsDictionary {
        .init()
            .codeSigningAllowed(false)
            .codeSigningRequired(false)
            .bitcodeEnabled(false)
    }
}