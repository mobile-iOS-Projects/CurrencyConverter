//
//  ClientRegistration.swift
//  Analytics
//
//  Created by Weiss, Alexander on 13.07.22.
//

import Foundation

// Client registration configuration object
struct ClientRegistration {
    /// The endpoint URL that is used to authenticate the SAP Mobile Start application
    let launchpadStartEndpoint: String

    init(launchpadStartEndpoint: String) {
        self.launchpadStartEndpoint = launchpadStartEndpoint
    }
}

extension ClientRegistration {
    /// Default registration, without any special registration options
    static var `default`: ClientRegistration = ClientRegistration(launchpadStartEndpoint: "unknown")

    /// Registration options for demo mode
    static var demoMode: ClientRegistration = ClientRegistration(launchpadStartEndpoint: "unknown")
}
