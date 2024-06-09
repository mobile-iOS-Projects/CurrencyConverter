//
//  Publishers+Validation.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 24.09.22.
//

import Combine
import Foundation

// MARK: - Typealiases
public typealias ValidationFailureClosure = () -> String

public typealias ValidationPublisher = AnyPublisher<ValidationResult, Never>

// MARK: - Validation Publisherr
public enum ValidationPublishers {
    /// Validation that the published property is a valid `URL` type
    static func urlValidation(
        for publisher: Published<String>.Publisher,
        failureMessage: @autoclosure @escaping ValidationFailureClosure
    ) -> ValidationPublisher {
        publisher.map { value in
            guard let url = URL(string: value),
                  url.isFileURL || (url.host != nil && url.scheme != nil)
            else {
                return .failure(message: failureMessage())
            }

            return .success
        }
        .dropFirst()
        .eraseToAnyPublisher()
    }

    // Validates whether a string property is non-empty.
    static func nonEmptyValidation(
        for publisher: Published<String>.Publisher,
        failureMessage: @autoclosure @escaping ValidationFailureClosure
    ) -> ValidationPublisher {
        publisher.map { value in
            guard !value.isEmpty else {
                return .failure(message: failureMessage())
            }
            return .success
        }
        .dropFirst()
        .eraseToAnyPublisher()
    }
}

// MARK: - Publisher Extension
extension Published.Publisher where Value == String {
    public func nonEmptyValidator(_ failureMessage: @autoclosure @escaping ValidationFailureClosure) -> ValidationPublisher {
        ValidationPublishers.nonEmptyValidation(for: self, failureMessage: failureMessage())
    }

    public func urlValidator(_ failureMessage: @autoclosure @escaping ValidationFailureClosure) -> ValidationPublisher {
        ValidationPublishers.urlValidation(for: self, failureMessage: failureMessage())
    }
}
