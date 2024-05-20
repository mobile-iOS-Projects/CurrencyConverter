//
//  EndpointProvider.swift
//  Networking
//
//  Created by Siarhei Runovich on 18.05.24.
//

import Foundation

public protocol EndpointProvider {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var token: String { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
    var mockFile: String? { get }
}

public extension EndpointProvider {
    var scheme: String {
        return "https"
    }

    var baseURL: String {
        return "v6.exchangerate-api.com"
    }

    var token: String {
        return ""
    }

    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = baseURL
        urlComponents.path = path
        if let queryItems {
            urlComponents.queryItems = queryItems
        }
        guard let url = urlComponents.url else {
            throw NetworkingError.internalError(reason: "Unable to create url")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setHeaders(from: ["true": "X-Use-Cache"])

        if !token.isEmpty {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        if let body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw NetworkingError.internalError(reason: "Error encoding http body")
            }
        }
        return urlRequest
    }
}
