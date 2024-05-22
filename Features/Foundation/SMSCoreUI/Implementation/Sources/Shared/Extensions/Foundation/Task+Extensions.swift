//  SAP Mobile Start Project
//  Task+Extensions.swift created on 26.07.22
//  Feature: SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//
//  No part of this publication may be reproduced or transmitted in any form or for any purpose
//  without the express permission of SAP SE. The information contained herein may be changed
//  without prior notice.

import Foundation

extension Task where Success == Never, Failure == Never {
    /// Suspends the current task for at least the given duration in seconds
    ///
    /// - Parameters:
    ///   - seconds: The second that the task will sleep
    public static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await Task.sleep(nanoseconds: duration)
    }
}
