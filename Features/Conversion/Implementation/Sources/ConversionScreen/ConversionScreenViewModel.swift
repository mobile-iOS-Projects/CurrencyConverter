//
//  ConversionScreenViewModel.swift
//  Conversion
//
//  Created by Siarhei Runovich on 10.06.24.
//

import Foundation
import Networking

@Observable
final class ConversionScreenViewModel {
    var conversionsCountries: ConversionsCountries?
    var currency: [Currency] = []
    let networking = Networking()

    // MARK: - Methods for fetching currency data
    func getCurrencyData() {
        Task {
            do {
                let results = try await networking.getRequest(
                    endpoint: CurrencyEndpoints.getCurrencies(
                        countryCode: CurrencyCountryType.unitedStatesDollar.rawValue
                    ),
                    responseModel: CurrencyData.self
                )
                currency = CurrencyCountryType.allCases
                    .filter { $0 != CurrencyCountryType.unitedStatesDollar}
                    .map {
                        Currency(code: $0.rawValue, rate: results.rates.getRate(of: $0.rawValue))
                }
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
