//
//  AnalyticsAPI.swift
//  AnalyticsAPI
//
//  Created by Weiss, Alexander on 13.07.22.
//

import Foundation

/// The interface for interacting with our Analytics Service
public protocol AnalyticsAPI {
    /// Initialize the analytics service
    func initialize()

    /// Returns the URL for a user survey
    func surveyURL() -> URL?

    #if os(iOS)
    /// Tracks an analytics event
    ///
    /// - Parameters
    ///   - event: The event to track
    func track(event: AnalyticsEvent)
    #endif
}
