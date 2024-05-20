//
//  URLSessionConfiguration+Extensions.swift
//  Networking
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

// MARK: URLSessionConfiguration
extension URLSessionConfiguration {
    /// Default SAP standard configuration
    public static var currencyConverterDefault: URLSessionConfiguration {
        var config = URLSessionConfiguration.default
        self.applySAPSecurityConfiguration(on: &config)
        return config
    }

    /// Default SAP standard configuration with caching
    public static func sapDefaultWith(cache: URLCache) -> URLSessionConfiguration {
        let config: URLSessionConfiguration = .currencyConverterDefault
        config.urlCache = cache
        return config
    }

    /// Applies  standard security related configuration
    ///
    /// Sets the following parameters:
    /// * timeoutIntervalForRequest = 30
    /// * timeoutIntervalForResource = 120
    ///
    /// - Parameters:
    ///   - config: The `URLSessionConfiguration` to apply security configuration to
    private static func applySAPSecurityConfiguration(on config: inout URLSessionConfiguration) {
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 120
        config.shouldUseExtendedBackgroundIdleMode = true
    }
}
