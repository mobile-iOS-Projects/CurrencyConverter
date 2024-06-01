//
//  Bool+Extensions.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

extension Bool {
    /// Initialize a boolean value from a `String` instance
    ///
    /// The following values are possible:
    /// * "0" -> false
    /// * "NO" -> false
    /// * "No" -> false
    /// * "no" -> false
    /// * "FALSE" -> false
    /// * "False" -> false
    /// * "false" -> false
    ///
    /// * "1" -> true
    /// * "01" -> true
    /// * "YES" -> true
    /// * "Yes" -> true
    /// * "yes" -> true
    /// * "TRUE" -> true
    /// * "True" -> true
    /// * "true" -> true
    ///
    /// All other values will result in the instance being initialised to `false`
    /// - Parameters:
    ///   - from: String instance to convert
    public init(from: String) {
        self = (from as NSString).boolValue
    }
}
