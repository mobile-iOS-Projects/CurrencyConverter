//
//  TimeInterval+Extensions.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

extension TimeInterval {
    public static func seconds(_ seconds: Int) -> TimeInterval {
        Double(seconds)
    }

    public static func minutes(_ minutes: Int) -> TimeInterval {
        .seconds(minutes * 60)
    }

    public static func hours(_ hours: Int) -> TimeInterval {
        .minutes(hours * 60)
    }

    public static func days(_ days: Int) -> TimeInterval {
        .hours(days * 24)
    }
}
