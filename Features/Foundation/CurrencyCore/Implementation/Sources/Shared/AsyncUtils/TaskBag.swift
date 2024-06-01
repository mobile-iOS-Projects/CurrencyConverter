//
//  TaskBag.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Combine
import Foundation

/// A utility class for managing cancellable tasks.
public actor TaskBag<ID: Hashable> {
    // MARK: - Public Properties
    /// The number of stored tasks
    public var storedTaskCount: Int {
        dict.count
    }

    // MARK: - Private Properties
    /// A dictionary holding the cancellable tasks.
    private var dict: [ID: AnyCancellable] = [:]

    /// Initializes a new TaskBag.
    public init() {}

    /// Cancel the task assosicated with `ID`.
    ///
    /// Cancelling the task will also remove the reference from the underlying storage of the bag.
    ///
    /// - Parameters:
    ///   - id: The ID of the task to cancel.
    public func cancel(id: ID) {
        dict[id]?.cancel()
        dict.removeValue(forKey: id)
    }

    /// Cancels all tasks in the bag.
    ///
    /// This will also remove all references from the underyling storage of the bag.
    public func cancelAll() {
        dict.values.forEach { $0.cancel() }
        dict.removeAll()
    }

    /// Adds a task to the bag
    ///
    /// The task can be cancelled with the given `ID`
    ///
    /// - Parameters:
    ///   - id: The ID for the task.
    ///   - cancellable: The cancellable task to add.
    public func add(id: ID, cancellable: AnyCancellable) {
        dict[id]?.cancel()
        dict[id] = cancellable
    }
}
