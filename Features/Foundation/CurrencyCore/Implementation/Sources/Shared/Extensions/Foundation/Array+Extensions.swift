//
//  Array+Extensions.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

extension Array {
    /// Safely subscript the array, retunring nil if the element cannot be found
    ///
    /// - Parameters:
    ///   - safeIndex: The index from the element should be read
    /// - Returns: The element, nil if the element is not found
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}

extension Array where Element: Hashable {
    public func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    public func containsSameElements(as other: [Element]) -> Bool {
        guard self.count == other.count else { return false }
        let selfSet = Set(self)
        let otherSet = Set(other)
        return selfSet.symmetricDifference(otherSet).isEmpty
    }
}
