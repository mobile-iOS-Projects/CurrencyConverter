//
//  Date+Extensions.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

extension Date {
    private static var relativeDateTimeFormatter = RelativeDateTimeFormatter()

    public var relativeTime: String {
        Date.relativeDateTimeFormatter.unitsStyle = .full
        Date.relativeDateTimeFormatter.dateTimeStyle = .named
        return Date.relativeDateTimeFormatter.localizedString(for: self, relativeTo: .now)
    }
}

extension Date?: Comparable {
    public static func < (lhs: Optional, rhs: Optional) -> Bool {
        lhs ?? .distantPast < rhs ?? .distantPast
    }
}
