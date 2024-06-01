//
//  DebugUtilities.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

/// Returns a debugging string based on `dump` for the given instance
///
/// - Parameter
///   - instance: Object to create a debug string from
/// - Returns: A string bsed on `dump`
public func dumpString(from instance: Any) -> String {
    var string = String()
    dump(instance, to: &string)
    return string
}
