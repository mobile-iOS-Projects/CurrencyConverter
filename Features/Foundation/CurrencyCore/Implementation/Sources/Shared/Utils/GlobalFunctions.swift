//
//  GlobalFunctions.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

/// Delays the execution of a closure by some seconds on the specified dispatch queue
///
/// - Parameters:
///   - seconds: Seconds to delay the execution. Fractions are supported
///   - queue: The queue instance to run the execution on
///   - closure: The closure to execute
public func delay(seconds: TimeInterval, on queue: DispatchQueue, _ closure: @escaping () -> Void) {
    queue.asyncAfter(deadline: .now() + seconds) {
        closure()
    }
}

/// Delays the execution of a closure by some seconds on the main queue
///
/// - Parameters:
///   - seconds: Seconds to delay the execution. Fractions are supported
///   - closure: The closure to execute
public func delayOnMain(seconds: TimeInterval, _ closure: @escaping () -> Void) {
    delay(seconds: seconds, on: DispatchQueue.main, closure)
}
