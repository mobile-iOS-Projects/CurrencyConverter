//
//  DataUnit.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

/// Represnts the digital data unit
public enum DataUnit {
    /// Data unit in bytes
    case byte(Int)

    /// Date unit in kilo bytes
    case kiloByte(Int)

    /// Data unit in mega bytes
    case megaByte(Int)

    /// Data unit in giga bytes
    case gigaByte(Int)

    /// Number of bytes
    public var bytes: Int {
        switch self {
        case let .byte(number):
            return number
        case let .kiloByte(number):
            return number * 1024
        case let .megaByte(number):
            return number * (1024 ** 2)
        case let .gigaByte(number):
            return number * (1024 ** 3)
        }
    }
}

// MARK: - Equatable
extension DataUnit: Equatable {
    public static func == (lhs: DataUnit, rhs: DataUnit) -> Bool {
        lhs.bytes == rhs.bytes
    }
}
