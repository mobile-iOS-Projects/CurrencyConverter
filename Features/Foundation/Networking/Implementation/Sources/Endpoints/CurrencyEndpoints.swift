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
            APIConstants.CurrencyAPIConstants.getCurrenciesPath
        }
    }

    public var baseURL: String {
        APIConstants.CurrencyAPIConstants.baseURL
    }

    public var method: RequestMethod {
        switch self {
        case .getCurrencies: .get
        }
    }
}
