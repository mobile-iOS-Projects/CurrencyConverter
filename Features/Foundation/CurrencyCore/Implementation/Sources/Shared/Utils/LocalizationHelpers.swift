//
//  LocalizationHelpers.swift
//  Core
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

/// Returns a localized string from the specified table
///
/// - Parameters:
///   - key: The key for a string in the specified table
///   - tableName: The name of the table containing the key-value pairs. Also, the suffix for the strings file (a file with
/// the.strings extension) to store the localized string. This defaults to the table in Localizable.strings when tableName is nil
/// or an empty string.
///   - bundle: The bundle from which to load the table from. Defaults to `Bundle.main`
/// - Returns: The result of sending localizedString(forKey:value:table:) to bundle, passing the specified key, value, and
/// tableName.
public func SMSLocalizedString(
    _ key: String,
    tableName: String? = nil,
    bundle: Bundle = Bundle.main
) -> String {
    NSLocalizedString(
        key,
        tableName: tableName,
        bundle: bundle,
        comment: ""
    )
}
