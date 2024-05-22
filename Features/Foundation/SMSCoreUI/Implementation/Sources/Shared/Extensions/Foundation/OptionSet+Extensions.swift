//
//  OptionSet+Extensions.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

// MARK: - NotContains
extension OptionSet {
    /// Returns a Boolean value that indicates whether the given element **not** exists in the set.
    ///
    /// - Parameters:
    ///   - element: An element to check
    /// - Returns: true if member does not exists in the set; otherwise, false.
    public func notContains(_ element: Element) -> Bool {
        !self.contains(element)
    }
}

// MARK: - OptionSetUpdate
extension OptionSet {
    /// Update the given feature flag based on the provided update
    ///
    /// - Parameters:
    ///   - update: The update to apply
    public mutating func update(with update: OptionSetUpdate<Element>) {
        switch update {
        case let .added(flag):
            self.insert(flag)
        case let .removed(flag):
            self.remove(flag)
        }
    }
}

public enum OptionSetUpdate<Element> {
    /// The given element should be added into the set
    case added(Element)

    /// The given element should be removed from the set
    case removed(Element)
}

extension OptionSetUpdate: Equatable where Element: Equatable {
    public static func == (lhs: OptionSetUpdate, rhs: OptionSetUpdate) -> Bool {
        switch (lhs, rhs) {
        case let (.added(element), .added(element2)):
            return element == element2
        case let (.removed(element), .removed(element2)):
            return element == element2
        default:
            return false
        }
    }
}
