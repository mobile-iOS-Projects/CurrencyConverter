//
//  EndpointProvider.swift
//  Networking
//
//  Created by Siarhei Runovich on 18.05.24.
//

import Foundation

// Define a protocol for providing endpoint details for network requests.
public protocol EndpointProvider {
    // The URL scheme (e.g., "http" or "https").
    var scheme: String { get }
    // The base URL of the API (e.g., "api.example.com").
    var baseURL: String { get }
    // The specific path for the API endpoint (e.g., "/v1/users").
    var path: String { get }
    // The HTTP method for the request (e.g., GET, POST, PUT, DELETE).
    var method: RequestMethod { get }
    // The authorization token to be included in the request headers.
    var token: String { get }
    // Any query items to be included in the URL (e.g., for filtering or sorting).
    var queryItems: [URLQueryItem]? { get }
    // The body of the request, usually for POST or PUT requests.
    var body: [String: Any]? { get }
    // The name of the mock file to be used for testing purposes.
    var mockFile: String? { get }
}

// MARK: Public Methods
extension EndpointProvider {
    public var scheme: String {
        "https"
    }

    public var token: String { "" }

    public var queryItems: [URLQueryItem]? { nil }

    public var body: [String: Any]? { nil }

    public var mockFile: String? { nil }

    public func asURLRequest() throws -> URLRequest {
        // Construct URL components
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = baseURL
        urlComponents.path = path
        urlComponents.queryItems = queryItems

        // Ensure the URL is valid
        guard let url = urlComponents.url else {
            throw NetworkingError.missingUrlForRequest
        }

        // Create and configure the URLRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        configureHeaders(for: &urlRequest)
        try configureBody(for: &urlRequest)

        return urlRequest
    }
}

// MARK: - Private Helper Methods
extension EndpointProvider {
    private func configureHeaders(for urlRequest: inout URLRequest) {
        let headers: [String: String] = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "X-Use-Cache": "true"
        ]

        urlRequest.setHeaders(from: headers)

        if !token.isEmpty {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }

    private func configureBody(for urlRequest: inout URLRequest) throws {
        guard let body else { return }

        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch let error as NSError {
            guard error.domain == NSURLErrorDomain else { throw NetworkingError.unknown(error: error) }
            throw NetworkingError.urlError(code: error.code)
        } catch {
            throw NetworkingError.unknown(error: error)
        }
    }
}
