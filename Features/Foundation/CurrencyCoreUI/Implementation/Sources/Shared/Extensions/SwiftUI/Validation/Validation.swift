//
//  Validation.swift
//  SMSCoreUITests
//
//  Created by Weiß, Alexander on 24.09.22.
//

import Foundation

public enum ValidationResult {
    /// Validation succeeded
    case success

    /// Validation failed
    case failure(message: String)

    public var isSuccess: Bool {
        if case .success = self {
            return true
        }
        return false
    }
}
