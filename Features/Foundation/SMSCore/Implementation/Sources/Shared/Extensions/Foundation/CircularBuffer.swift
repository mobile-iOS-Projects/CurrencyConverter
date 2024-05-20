//
//  CircularBuffer.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

public actor CircularBuffer<Element> {
    private var buffer: [Element] = []
    private var index = 0

    public private(set) var capacity: Int = 1

    public init(capacity: Int) {
        guard capacity != 0 else { return }
        self.capacity = abs(capacity)
    }

    /// Inserts the given element into the buffer. If the buffer reaches its capacity it circular overwrites existing entries
    /// - Parameters:
    ///    - element: The element that should be inserted
    public func insert(element: Element) {
        // The upcoming index after insertion of the element
        let upcomingIndex = (index + 1) % capacity

        guard self.buffer.count < capacity else {
            buffer[index % capacity] = element
            index = upcomingIndex
            return
        }
        buffer.append(element)
        index = upcomingIndex
    }

    /// Pops the last inserted element from the buffer and removes it
    ///
    /// - Returns: The element, nil if no element is found
    public func popLast() -> Element? {
        // The index of the element to be removed and returned
        let poppedElementIndex = (index + capacity - 1) % capacity

        // Make sure that the index is existing
        guard poppedElementIndex < buffer.count else { return nil }

        let element = buffer.remove(at: poppedElementIndex)
        index = poppedElementIndex
        return element
    }

    /// Reads all elements contained in the buffer without removing them
    /// Elements are sorted in reversed order as they were added
    ///
    /// - Returns: An array with all elements in the buffer without removing them
    public func readAll() -> [Element] {
        let prefix = buffer.prefix(upTo: index).reversed()
        let postfix = buffer.reversed().prefix(through: (buffer.count - index - 1) % capacity)

        var result: [Element] = []
        result.append(contentsOf: prefix)
        result.append(contentsOf: postfix)

        return result
    }
}

extension CircularBuffer where Element: Equatable {
    /// Checks whether the given element is contained in the buffer
    /// - Parameters:
    ///    - element: The element that should be checked
    /// - Returns: True if element is contained, False else
    public func contains(element: Element) -> Bool {
        buffer.contains(element)
    }
}
