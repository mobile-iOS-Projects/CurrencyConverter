//
//  URLRequest+Extension.swift
//  Networking
//
//  Created by Weiss, Alexander on 10.02.22.
//

import Foundation
import SMSCore

// MARK: - URLRequest+Withable

extension URLRequest: Withable {}

// MARK: - URLRequest+HTTPHeaders

extension URLRequest {
    /// Set the HTTP headers of this `URLRequest` instance
    ///
    /// - Parameters
    ///   - headers: Headers to be set
    mutating func setHeaders(from headers: HTTPHeaders) {
        headers.forEach { key, value in
            self.setValue(value, forHTTPHeaderField: key)
        }
    }
}
