//
//  Rates.swift
//  ConversionAPI
//
//  Created by Siarhei Runovich on 11.06.24.
//

import Foundation

struct Rates: Decodable {
    let BYN: Double
    let EUR: Double?
    let PLN: Double?
    let RUB: Double?
    let UAH: Double?
    let USD: Double?

    var ratesDictionary: [String: Double?] {
        [
            "BYN": BYN,
            "EUR": EUR,
            "PLN": PLN,
            "RUB": RUB,
            "USD": USD,
            "UAH": UAH,
        ]
    }

    func getRate(of code: String) -> Double {
        (ratesDictionary[code] ?? 0.0) ?? 0
    }
}
