//
//  KeychainError.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

/// Error cases for accessing the Keychain
public enum KeychainError: LocalizedError {
    /// Item could not be read from the Keychain
    case readFailed(error: ReadingError)

    /// Item could not be stored to the Keychain
    case storeFailed(status: OSStatus)

    /// Item could not be deleted from the Keychain
    case deleteFailed(status: OSStatus)

    /// Encoding of given type to Data failed. This is necessary for the type to be saved in the Keychain
    case encodingFailed(message: String)

    /// Decoding of given type from Data failed. This is necessary for the type to be read from the Keychain
    case decodingFailed(message: String)
}

extension KeychainError: Equatable {
    public static func == (lhs: KeychainError, rhs: KeychainError) -> Bool {
        switch (lhs, rhs) {
        case let (.readFailed(lhsError), .readFailed(rhsError)):
            return lhsError == rhsError
        case let (.storeFailed(lhsStatus), .storeFailed(rhsStatus)):
            return lhsStatus == rhsStatus
        case let (.deleteFailed(lhsStatus), .deleteFailed(rhsStatus)):
            return lhsStatus == rhsStatus
        case let (.encodingFailed(lhsMessage), .encodingFailed(rhsMessage)):
            return lhsMessage == rhsMessage
        case let (.decodingFailed(lhsMessage), .decodingFailed(rhsMessage)):
            return lhsMessage == rhsMessage
        default:
            return false
        }
    }
}

extension KeychainError {
    public var errorDescription: String? {
        switch self {
        case let .readFailed(error):
            return ["Reading failed", error.errorDescription]
                .compactMap { $0 }
                .joined(separator: ": ")
        case let .storeFailed(status):
            return "Storing failed with status code \(status) reported by the system"
        case let .deleteFailed(status):
            return "Deleting failed with status code \(status) reported by the system"
        case let .encodingFailed(message):
            return "Encoding failed: \(message)"
        case let .decodingFailed(message):
            return "Decoding failed: \(message)"
        }
    }
}

extension KeychainError {
    /// Occurs when item can not be read from the Keychain
    public enum ReadingError: LocalizedError {
        /// The keychain's storage does not have the requested item
        case itemMissing

        /// A query for fetching an item is not correct (some attributes are missing or incorrect)
        case incorrectQuery

        /// An error which includes status code reported by the system
        case unknown(status: OSStatus)
    }
}

extension KeychainError.ReadingError: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.itemMissing, .itemMissing), (.incorrectQuery, .incorrectQuery):
            return true
        case let (.unknown(lhsStatus), .unknown(rhsStatus)):
            return lhsStatus == rhsStatus
        default:
            return false
        }
    }
}

extension KeychainError.ReadingError {
    public var errorDescription: String? {
        switch self {
        case .itemMissing:
            return "The keychain's storage does not have the requested item"
        case .incorrectQuery:
            return "A query for fetching an item is not correct (some attributes are missing or incorrect)"
        case let .unknown(statusCode):
            return "An error with status code \(statusCode) reported by the system"
        }
    }
}
