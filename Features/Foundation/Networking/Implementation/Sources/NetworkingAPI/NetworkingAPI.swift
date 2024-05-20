//
//  NetworkingAPI.swift
//  NetworkingAPI
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

/// A protocol defining a networking API with a methods for making requests.
public protocol NetworkingAPI {
    /// Makes an asynchronous GET request to the specified endpoint and decodes
    /// the response into the provided model type.
    ///
    /// - Parameters:
    ///   - endpoint: The endpoint to which the GET request should be made, 
    ///   conforming to the `EndpointProvider` protocol.
    ///   - responseModel: The type of the model that the response should be decoded into.
    ///    This type must conform to the `Decodable` protocol.
    ///
    /// - Returns: An instance of the specified `responseModel` type containing the decoded response data.
    ///
    /// - Throws: An error if the request fails or the response cannot be decoded into the specified model type.
    func getRequest<T: Decodable>(endpoint: EndpointProvider, responseModel: T.Type) async throws -> T
}
