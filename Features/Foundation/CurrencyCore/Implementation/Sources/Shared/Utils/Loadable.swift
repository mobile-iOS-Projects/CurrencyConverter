//
//  Loadable.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

/// Represent the state of a value that is loaded asynchronously
public enum Loadable<Value, E: Error> {
    /// Initial value
    case initial

    /// Loading state, with optional last known value
    case loading(lastValue: Value? = nil)

    /// Loaded value
    case value(Value)

    /// Error during loading the value, with optional last known value
    case error(E, lastValue: Value? = nil)
}

extension Loadable {
    public static var loading: Loadable {
        Loadable.loading()
    }
}

// MARK: - Hashable
extension Loadable: Hashable where Value: Hashable {
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .initial:
            hasher.combine(0)
            hasher.combine("initial")
        case let .loading(lastValue):
            hasher.combine(1)
            hasher.combine("loading")
            if let value = lastValue {
                hasher.combine(value)
            }
        case let .value(value):
            hasher.combine(2)
            hasher.combine("value")
            hasher.combine(value)
        case let .error(error, lastValue):
            hasher.combine(3)
            hasher.combine("error")
            hasher.combine(error.localizedDescription)
            if let value = lastValue {
                hasher.combine(value)
            }
        }
    }
}

extension Loadable {
    /// Optional value if available
    ///
    /// Only in .loading, .value or .error state
    public var value: Value? {
        switch self {
        case let .loading(lastValue):
            return lastValue
        case let .value(value):
            return value
        case let .error(_, lastValue):
            return lastValue
        default:
            return nil
        }
    }

    /// Error value
    ///
    /// Only in .error state
    public var error: Error? {
        switch self {
        case let .error(error, _):
            return error
        default:
            return nil
        }
    }

    /// Determines whether the current state is loading
    ///
    /// Returns true if self = .loading
    /// Helps to circumvent an `if case` check
    public var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
}

extension Loadable: Equatable where Value: Equatable {
    public static func == (lhs: Loadable<Value, E>, rhs: Loadable<Value, E>) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case let (.loading(lhsV), .loading(rhsV)):
            return lhsV == rhsV
        case let (.value(lhsV), .value(rhsV)):
            return lhsV == rhsV
        case let (.error(lhsE, lhsV), .error(rhsE, rhsV)):
            return lhsE.localizedDescription == rhsE.localizedDescription && lhsV == rhsV
        default:
            return false
        }
    }
}

extension Loadable {
    /// A stripped version of the `Loadable` without associated values
    public enum Stripped: Equatable {
        case initial
        case loading
        case value
        case error
    }

    /// A stripped version of the `Loadable` without associated values
    public var stripped: Stripped {
        switch self {
        case .initial:
            return .initial
        case .loading:
            return .loading
        case .value:
            return .value
        case .error:
            return .error
        }
    }
}

extension Loadable {
    public func mapValue<NewValue>(_ transform: (Value) -> NewValue) -> Loadable<NewValue, E> {
        switch self {
        case .initial:
            return .initial
        case let .loading(lastValue):
            return .loading(lastValue: lastValue.map(transform))
        case let .value(value):
            return .value(transform(value))
        case let .error(err, lastValue):
            return .error(err, lastValue: lastValue.map(transform))
        }
    }
}
