//
//  ContentViewModel.swift
//  App
//
//  Created by Siarhei Runovich on 18.05.24.
//

import Foundation
import Factory
import Networking

struct Currency: Decodable {
    let result: String
    let documentation, termsOfUse: String
    let timeLastUpdateUnix: Int
    let timeLastUpdateUTC: String
    let timeNextUpdateUnix: Int
    let timeNextUpdateUTC, baseCode: String
    let conversionRates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case result, documentation
        case termsOfUse = "terms_of_use"
        case timeLastUpdateUnix = "time_last_update_unix"
        case timeLastUpdateUTC = "time_last_update_utc"
        case timeNextUpdateUnix = "time_next_update_unix"
        case timeNextUpdateUTC = "time_next_update_utc"
        case baseCode = "base_code"
        case conversionRates = "conversion_rates"
    }
}

@Observable
final class ContentViewModel {
    @ObservationIgnored
    @Injected (\.networkingAPI) var networkingAPI
    
}

extension ContentViewModel {
    func getCurrency() {
        Task {
            do {
                let enpoint = CurrencyEndpoints.getCurrencies

                let result = try await networkingAPI.getRequest(endpoint: enpoint, responseModel: Currency.self)
                print("result: \(result)")
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
