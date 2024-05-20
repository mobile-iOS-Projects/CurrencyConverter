//
//  CurrencyEndpoints.swift
//  Networking
//
//  Created by Siarhei Runovich on 18.05.24.
//

import Foundation

public enum CurrencyEndpoints: EndpointProvider {
    case getCurrencies

    public var path: String {
        switch self {
        case .getCurrencies:
            return "/v6/330554763ea281d28c4f452f/latest/USD"
        }
    }

    public var method: RequestMethod {
        switch self {
        case .getCurrencies:
            return .get
        }
    }

    public var queryItems: [URLQueryItem]? {
        return nil
    }

    public var body: [String: Any]? {
        return nil
    }

    public var mockFile: String? {
        return nil
    }
}
