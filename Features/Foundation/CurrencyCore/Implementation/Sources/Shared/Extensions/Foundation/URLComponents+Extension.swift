//
//  URLComponents+Extension.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

extension URLComponents {
    public init?(ignoreSemicolonEncoding url: URL, resolvingAgainstBaseURL: Bool = true) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: resolvingAgainstBaseURL) else { return nil }
        self = components
        self.revertSemicolonEncoding()
    }

    public init?(ignoreSemicolonEncoding string: String) {
        guard let components = URLComponents(string: string) else { return nil }
        self = components
        self.revertSemicolonEncoding()
    }

    public mutating func revertSemicolonEncoding() {
        if let path = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed.union([";"])) {
            percentEncodedPath = path
        }
    }

    public func revertedSemicolonEncoding() -> URLComponents {
        var components = self
        components.revertSemicolonEncoding()
        return components
    }
}
