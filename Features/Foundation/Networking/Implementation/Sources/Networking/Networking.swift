//
//  Networking.swift
//  Networking
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

public final class Networking {
    // MARK: Private Properties

    // URLSession, used for non authenticated requests
    private let urlSession: URLSession

    // MARK: - Initializer
    public init(urlSessionConfiguration: URLSessionConfiguration = .currencyConverterDefault) {
        self.urlSession = URLSession(configuration: urlSessionConfiguration)
    }
}

// MARK: NetworkingAPI
extension Networking: NetworkingAPI {
    public func getRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T {
        do {
            // Execute the network request and await the response.
            let resourceResponse: ResourceResponse = try await urlSession.data(for: endpoint.asURLRequest())

            // Ensure the response is an HTTPURLResponse to access the status code.
            guard let response = resourceResponse.response as? HTTPURLResponse else {
                throw NetworkingError.internalError(reason: "Response was not a HTTPURLResponse")
            }

            // Handle the response based on the status code.
            guard response.isSuccess else {
                throw NetworkingError.httpError(data: resourceResponse.data, response: response)
            }

            return try JSONDecoder().decode(responseModel, from: resourceResponse.data)
        } catch let error as NSError {
            guard error.domain == NSURLErrorDomain else { throw NetworkingError.unknown(error: error) }
            throw NetworkingError.urlError(code: error.code)
        } catch {
            throw NetworkingError.unknown(error: error)
        }
    }
}
