//
//  Semaphore.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

/// A semaphore which allows to control access to a shared resource.
/// It helps in managing concurrent access to resources by limiting the number
/// of tasks that can access the resource simultaneously.
public actor Semaphore {
    /// Is used by the semaphore to decide whether a task should get access to a shared resource or not.
    /// The counter value changes when we call `signal()` or `wait()` function
    private var count: Int
    /// A list of continuations which are connected to certain tasks.
    /// The tasks wait to get access to a shared resource
    private var waiters: [CheckedContinuation<Void, Never>]

    /// Create an `SMSSemaphore` instance
    ///
    /// - Parameters:
    ///   - count: Counter value that represents the number of tasks which have access to a shared resource at a given moment
    public init(count: Int = 0) {
        self.count = count
        self.waiters = []
    }

    /// Call `wait()` each time before using the shared resource.
    /// It basically asks the semaphore whether the shared resource is available or not.
    /// If not, the task will wait
    public func wait() async {
        count -= 1
        // swiftlint:disable empty_count
        guard count < 0 else { return }

        await withCheckedContinuation {
            waiters.append($0)
        }
    }

    /// Call `signal()` each time after using the shared resource.
    /// It basically signals the semaphore that the task is done interacting with the shared resource.
    ///
    /// - Returns: `true` if a suspended task is resumed. Otherwise, the result is `false`,
    /// meaning that no task was waiting for the semaphore
    @discardableResult
    public func signal() -> Bool {
        let previousCount = count
        count += 1
        if previousCount < 0, !waiters.isEmpty {
            waiters.removeFirst().resume()
            return true
        } else {
            // Queue is empty, no one is waiting
            return false
        }
    }
}
