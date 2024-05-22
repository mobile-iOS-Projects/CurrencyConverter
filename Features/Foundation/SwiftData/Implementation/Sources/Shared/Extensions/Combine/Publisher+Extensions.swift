//
//  Publisher+Extensions.swift
//  Core
//
//  Created by Sergey Runovich on 6.05.24.
//

import Combine
import Foundation

extension AnyPublisher {
    public static func cancelled(error: Failure) -> AnyPublisher<Output, Failure> {
        Future<Output, Failure> { promise in
            promise(.failure(error))
        }
        .eraseToAnyPublisher()
    }

    public func sinkToResult(_ result: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            switch completion {
            case let .failure(error):
                result(.failure(error))
            default:
                break
            }
        }, receiveValue: { value in
            result(.success(value))
        })
    }
}

// swiftlint:disable disable_print
extension Publisher {
    /// Includes the current element as well as the previous element from the upstream publisher in a tuple where the previous
    /// element is optional.
    /// The first time the upstream publisher emits an element, the previous element will be `nil`.
    ///
    ///     let range = (1...5)
    ///     cancellable = range.publisher
    ///         .withPrevious()
    ///         .sink { print ("(\($0.previous), \($0.current))", terminator: " ") }
    ///      // Prints: "(nil, 1) (Optional(1), 2) (Optional(2), 3) (Optional(3), 4) (Optional(4), 5) ".
    ///
    /// - Returns: A publisher of a tuple of the previous and current elements from the upstream publisher.
    public func withPrevious() -> AnyPublisher<(previous: Output?, current: Output), Failure> {
        scan((Output?, Output)?.none) { previous, current in
            (previous?.1, current)
        }
        .compactMap { $0 }
        .eraseToAnyPublisher()
    }

    /// Includes the current element as well as the previous element from the upstream publisher in a tuple where the previous
    /// element is not optional.
    /// The first time the upstream publisher emits an element, the previous element will be the `initialPreviousValue`.
    /// ```
    ///     let range = (1...5)
    ///     cancellable = range.publisher
    ///         .withPrevious(0)
    ///         .sink { print ("(\($0.previous), \($0.current))", terminator: " ") }
    ///      // Prints: "(0, 1) (1, 2) (2, 3) (3, 4) (4, 5) ".
    /// ```
    /// - Parameters:
    ///   - initialPreviousValue: The initial value to use as the "previous" value when the upstream publisher emits for the first
    /// time.
    /// - Returns: A publisher of a tuple of the previous and current elements from the upstream publisher.
    public func withPrevious(_ initialPreviousValue: Output) -> AnyPublisher<(previous: Output, current: Output), Failure> {
        scan((initialPreviousValue, initialPreviousValue)) { previous, current in
            (previous.1, current)
        }
        .eraseToAnyPublisher()
    }
}

extension Publisher {
    /// A custom debounce operator that already applies some default values for the SAP Mobile Start application
    ///
    /// - Parameters:
    ///   - timeInterval: The timeInterval to wait until publishing new elements. If left empty, 0.5 seconds is the default value
    /// - Returns:  A publisher of the value, delayed by `timeInterval`
    public func smsDebounce(
        for timeInterval: DispatchQueue.SchedulerTimeType
            .Stride = .seconds(0.5)
    ) -> AnyPublisher<Output, Failure> {
        debounce(for: timeInterval, scheduler: DispatchQueue.main).eraseToAnyPublisher()
    }
}
