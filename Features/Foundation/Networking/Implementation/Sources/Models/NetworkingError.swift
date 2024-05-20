//
//  NetworkingError.swift
//  NetworkingAPI
//
//  Created by Siarhei Runovich on 18.05.24.
//

import Foundation

// MARK: - NetworkingError

/// Error that occurred while loading data from the network
public enum NetworkingError: Error {
    /// Attempt to make a network call without being authorized to do so
    case unauthorizedNetworkCall

    /// Feature internal error
    case internalError(reason: String)

    /// Request without url cannot be executed
    case missingUrlForRequest

    /// Error occurred while performing a HTTP request
    case httpError(data: Data?, response: HTTPURLResponse)

    /// Download validation error
    case validationError(error: ValidationError)

    /// NSURLError with respective error code
    case urlError(code: Int)

    /// An unknown error occurred
    case unknown(error: Error)
}

// MARK: Initializer
extension NetworkingError {
    init(from error: Error) {
        switch error {
        case let error as NetworkingError:
            self = error
        case let error as ValidationError:
            self = .validationError(error: error)
        case let error as NSError:
            guard error.domain == NSURLErrorDomain else {
                self = .unknown(error: error)
                return
            }
            self = .urlError(code: error.code)
        default:
            self = .unknown(error: error)
        }
    }
}

// MARK: Equatable
extension NetworkingError: Equatable {
    public static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs, rhs) {
        case (.unauthorizedNetworkCall, .unauthorizedNetworkCall):
            return true
        case let (.internalError(lhsReason), .internalError(rhsReason)):
            return lhsReason == rhsReason
        case (.missingUrlForRequest, .missingUrlForRequest):
            return true
        case let (.httpError(lhsData, lhsResponse), .httpError(rhsData, rhsResponse)):
            return lhsData == rhsData &&
                lhsResponse.statusCode == rhsResponse.statusCode &&
                lhsResponse.url == rhsResponse.url
        case let (.validationError(lhsError), .validationError(rhsError)):
            return lhsError == rhsError
        case let (.urlError(lhsErrorCode), .urlError(rhsErrorCode)):
            return lhsErrorCode == rhsErrorCode
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}

// MARK: - NetworkingError.ValidationError
public extension NetworkingError {
    /// Errors that occur during download validation
    enum ValidationError: Error {
        /// The file type does not match the file type from the ValidationConfiguration
        case invalidFileType

        /// The size if the file downloaded exceeds the number in the ValidationConfiguration
        case payloadSizeLimitBytes
    }
}

// MARK: - Equatable
extension NetworkingError.ValidationError: Equatable {
    public static func == (lhs: NetworkingError.ValidationError, rhs: NetworkingError.ValidationError) -> Bool {
        switch (lhs, rhs) {
        case (.payloadSizeLimitBytes, .payloadSizeLimitBytes):
            return true
        case (.invalidFileType, .invalidFileType):
            return true
        default:
            return false
        }
    }
}
