//
//  CurrencyEndpoints.swift
//  Networking
//
//  Created by Siarhei Runovich on 18.05.24.
//

import Foundation

public enum CurrencyEndpoints: EndpointProvider {
    case getCurrencies(countryCode: String)

    public var path: String {
        switch self {
        case let .getCurrencies(countryCode):
            APIConstants.CurrencyAPIConstants.getCurrenciesPath(code: countryCode).getValue
        }
    }

    public var baseURL: String {
        APIConstants.CurrencyAPIConstants.baseURL.getValue
    }

    public var method: RequestMethod {
        switch self {
        case .getCurrencies: .get
        }
    }
}
