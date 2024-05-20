//
//  Combine+Async.swift
//  Core
//
//  Created by Sergey Runovich on 6.05.24.
//

import Combine
import Foundation

/// Adapter to seamlessly convert between Async/Await and Combine world
public enum CombineAsyncAdapter {
    /// Convert an `AnyPublisher` into an async/await context
    ///
    /// - Warning: This conversion method is meant to be used for publishers that publish a __single__ value and finish after
    /// that. If you want to convert a publisher that publishes multiple values consider the following conversion:
    /// ```swift
    /// for try await value in publisher.values {
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - publisher: The publisher to use in an async/await context
    ///   - storeIn: The CancelBag to store in the publisher
    /// - Returns: The value of the success case of the `publisher`
    public static func adaptCombineToAsync<T>(
        _ publisher: AnyPublisher<T, some Error>,
        storeIn cancelBag: CancelBag
    ) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            publisher
                .sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case let .failure(error):
                            continuation.resume(throwing: error)
                        }
                    },
                    receiveValue: { value in
                        continuation.resume(returning: value)
                    }
                )
                .store(in: cancelBag)
        }
    }

    /// Converts an async closure into an `AnyPublisher` instance
    ///
    /// - Parameters:
    ///   - completion: async closure to convert into an `AnyPublisher`
    /// - Returns: An `AnyPublisher` instance
    public static func adaptAsyncToCombine<T>(_ completion: @escaping () async throws -> T) -> AnyPublisher<T, Error> {
        Deferred {
            Future<T, Error> { promise in
                Task {
                    do {
                        let result = try await completion()
                        promise(.success(result))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
