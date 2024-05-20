//
//  Sequence+Extensions.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

// MARK: - Unique Sequence
extension Sequence where Iterator.Element: Hashable {
    /// Uniquify the given sequence
    ///
    /// - Complexity: O(n) where `n` is the number of items in the given sequence
    /// - Returns: A sequence with unique elements
    public func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

extension Sequence {
    /// Uniquify the given sequence based on a keypath property
    ///
    /// - Complexity: O(n) where `n` is the number of items in the given sequence
    /// - Parameters:
    ///   - keyPath: Keypath used to uniquify the elements in the sequenece
    /// - Returns: A sequence with unique elements
    public func uniqued<Type: Hashable>(by keyPath: KeyPath<Element, Type>) -> [Element] {
        var set = Set<Type>()
        return filter { set.insert($0[keyPath: keyPath]).inserted }
    }
}

// MARK: - Sorting

public struct SortDescriptor<Value> {
    // MARK: - Properties

    /// Comparison method
    var compare: (Value, Value) -> ComparisonResult

    // MARK: - Initializer
    init(comparison compare: @escaping (Value, Value) -> ComparisonResult) {
        self.compare = compare
    }
}

extension SortDescriptor {
    /// Sort Descriptor based on a `Keypath`
    public static func keyPath(_ keyPath: KeyPath<Value, some Comparable>) -> Self {
        Self { valueA, valueB in
            let keypathValueA = valueA[keyPath: keyPath]
            let keypathValueB = valueB[keyPath: keyPath]

            guard keypathValueA != keypathValueB else {
                return .orderedSame
            }

            return keypathValueA < keypathValueB ? .orderedAscending : .orderedDescending
        }
    }
}

public enum SortOrder {
    case ascending
    case descending
}

extension Sequence {
    public func sorted(
        using descriptors: [SortDescriptor<Element>],
        order: SortOrder = .ascending
    ) -> [Element] {
        sorted { valueA, valueB in
            for descriptor in descriptors {
                let result = descriptor.compare(valueA, valueB)

                switch result {
                case .orderedSame:
                    // Next descriptor need to determine the sort order
                    break
                case .orderedAscending:
                    return order == .ascending
                case .orderedDescending:
                    return order == .descending
                }
            }

            // No iterator was able to determine the sort order
            return false
        }
    }
}
