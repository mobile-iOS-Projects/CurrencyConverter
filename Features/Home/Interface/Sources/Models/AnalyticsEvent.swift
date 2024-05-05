//
//  AnalyticsEvent.swift
//  AnalyticsAPI
//
//  Created by Weiß, Alexander on 24.09.22.
//

#if os(iOS)
import Foundation

// MARK: - Analytics Event
public enum AnalyticsEvent {
    case alchemer
    case dynatrace
}

// MARK: - Alchemer Event
public struct AlchemerEvent: Identifiable {
    // MARK: Properties
    public let id: String

    // MARK: - Initializer
    public init(id: String) {
        self.id = id
    }
}

// MARK: - ExpressibleByStringLiteral
extension AlchemerEvent: ExpressibleByStringLiteral {
    public typealias StringLiteralType = String
    public init(stringLiteral id: StringLiteralType) {
        self.id = id
    }
}

extension AlchemerEvent: ExpressibleByStringInterpolation { /* no-op */ }

// MARK: - DynatraceEvent Event
public struct DynatraceEvent: Identifiable {
    // MARK: Properties
    public let id: String
    public let parameters: [String: Any]?

    // MARK: - Initializer
    public init(id: String, parameters: [String: Any]?) {
        self.id = id
        self.parameters = parameters
    }
}
#endif
