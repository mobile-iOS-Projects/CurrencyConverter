//
//  APIConstants.swift
//  Networking
//
//  Created by Siarhei Runovich on 22.05.24.
//

import Foundation

enum APIConstants {
    enum CurrencyAPIConstants {
        case getCurrenciesPath(code: String)
        case baseURL

        var getValue: String {
            switch self {
            case let .getCurrenciesPath(code):
                "/v6/330554763ea281d28c4f452f/latest/\(code)"
            case .baseURL:
                "v6.exchangerate-api.com"
            }
        }
    }
}
