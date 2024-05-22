//
//  URL+Extensions.swift
//  Core
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

// MARK: - Initializers
extension URL {
    public init?(string: String?) {
        guard let string else { return nil }
        self.init(string: string)
    }

    public init?(unencodedString: String?) {
        guard let string = unencodedString else { return nil }
        self.init(string: string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
    }

    public init?(arbitraryEncodedString: String?) {
        guard let string = arbitraryEncodedString else { return nil }

        let url: URL? = if #available(iOS 17, watchOS 10, *) {
            URL(string: string, encodingInvalidCharacters: false)
        } else {
            URL(string: string)
        }

        if url == nil {
            self.init(string: string.replacingOccurrences(of: " ", with: "%20"))
        } else {
            self.init(string: string)
        }
    }
}

// MARK: - Redacted
extension URL {
    /// A String representation from this URL redacted by escaping all privacy relevant fields with asterisk characters.
    ///
    /// Privacy relevant fields are path component names and query parameter values.
    /// Examples:
    /// * http://testhost/testPath?key1=value1&key2=value2 is encoded to http://testhost/testPath?key1=***&key2=***
    /// * http://testhost/testPath('123')?key=queryValue is encoded to http://testhost/testPath(***)?key=***
    public var redacted: String {
        guard let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false) else {
            return ""
        }

        var result = "\(scheme ?? "http")://"
        if let host {
            result += host
        }
        if let port {
            result += ":\(port)"
        }

        let filteredPathComponents: [String] = pathComponents.map {
            let startTokens = $0.components(separatedBy: "(")
            return startTokens.count == 2 ? "\(startTokens[0])(***)" : $0
        }
        if !filteredPathComponents.isEmpty {
            let filteredPathComponentsString: String = filteredPathComponents.joined(separator: "/")
                .replacingOccurrences(of: "//", with: "/")
            result += filteredPathComponentsString
        }

        if let queryItems = urlComponents.queryItems {
            let filteredQuery: [String] = queryItems.map { item in
                "\(item.name)=***"
            }
            let filteredQueryString: String = filteredQuery.joined(separator: "&")
            result += "?\(filteredQueryString)"
        }

        return result
    }

    /// It appends the special parameters for a headerless UI5 application.
    /// - Returns: A URL with the UI5 headerless parameter
    /// Examples:
    /// Given: https://myhost/ui5app
    /// Return: https://myhost/ui5app?sap-ushell-config=headerless
    public var headerLessUI5: URL? {
        guard var components = URLComponents(
            url: self,
            resolvingAgainstBaseURL: true
        ) else { return self }

        let queryItem = URLQueryItem(
            name: "sap-ushell-config",
            value: "headerless"
        )
        components.queryItems = (components.queryItems ?? []) + [queryItem]
        return components.url
    }

    /// It detects if the URL points to a Fiori Apps library.
    /// - Returns: True, if the URL is for a Fiori Apps library
    public var isFioriAppsLibraryUrl: Bool {
        self.host?.lowercased() == "fioriappslibrary.hana.ondemand.com"
    }

    /// It checks if the
    public var isHTTPURL: Bool {
        self.scheme?.lowercased().contains("http") ?? false
    }

    /// A relative URL is a URL that does not specify the complete network location, but only the path relative to a base URL.
    /// In this implementation, the URL is considered relative if its path component starts with a forward slash ('/').
    /// This understanding of a relative URL may differ from the official RFC 1808 specification.
    ///
    /// - Returns: true if the URL is relative, otherwise, false.
    public var isRelativeURL: Bool {
        self.path.hasPrefix("/")
    }

    /// Convert potential http scheme into https scheme
    /// - Warning: This not only changes the scheme but can also change the encoding of url which could cause issues.
    public var convertHTTP2HTTPsScheme: URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return self }

        if components.scheme == "http" {
            components.scheme = "https"
        }

        if let url = components.url {
            return url
        }

        return self
    }

    /// Returns a new URL by adding the query items, or self if the URL doesn't support it.
    /// - Warning: This not only appends given `URLQueryItem`s but can also change the encoding of url which could cause issues.
    /// - Parameters:
    ///   - queryItems: Array of URLQueryItems to add to the URL.
    ///   - deduplicate: Set to true to not add URLQueryItems to the url that are already part of the URL.
    ///                  Only the name of the query item is checked.
    ///   - clearFragment: Set to true to remove the fragment part of the URL.
    /// - Returns: A URL with the appended query items. Semicolons in the path of the URL are not percent encoded.
    public func appending(_ queryItems: [URLQueryItem], deduplicate: Bool = false, clearFragment: Bool = false) -> URL? {
        guard !queryItems.isEmpty, var urlComponents = URLComponents(ignoreSemicolonEncoding: self) else {
            return self
        }

        var queryItemsToAdd: [URLQueryItem] = []
        if deduplicate {
            for queryItem in queryItems {
                if !(urlComponents.queryItems ?? []).contains(where: { $0.name == queryItem.name }) {
                    queryItemsToAdd.append(queryItem)
                }
            }
        } else {
            queryItemsToAdd = queryItems
        }

        if clearFragment {
            urlComponents.fragment = nil
        }

        urlComponents.queryItems = (urlComponents.queryItems ?? []) + queryItemsToAdd
        return urlComponents.url
    }

    /// Returns a new URL by removing query items with provided names, or self if the URL doesn't support it.
    /// - Warning: This not only removes `URLQueryItem`s with given names
    /// but can also change the encoding of url which could cause issues.
    public func removeQueryItems(with names: [String]) -> URL {
        guard !names.isEmpty,
              var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = urlComponents.queryItems,
              !queryItems.isEmpty
        else { return self }

        urlComponents.queryItems = queryItems.filter { !names.contains($0.name) }
        if let updatedQueryItems = urlComponents.queryItems, updatedQueryItems.isEmpty {
            urlComponents.query = nil
        }
        return urlComponents.url ?? self
    }

    /// Check whether the URL contains a query item with provided name.
    public func containsQueryItem(with name: String) -> Bool {
        guard let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = urlComponents.queryItems else { return false }

        return queryItems.contains { $0.name == name }
    }
}
