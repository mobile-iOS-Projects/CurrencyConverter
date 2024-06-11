//
//  CurrencyData.swift
//  ConversionAPI
//
//  Created by Siarhei Runovich on 10.06.24.
//

import Foundation

struct CurrencyData: Decodable {
    let baseCode: String
    let rates: Rates

    enum CodingKeys: String, CodingKey {
        case baseCode = "base_code"
        case rates = "conversion_rates"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseCode = try container.decode(String.self, forKey: .baseCode)
        self.rates = try container.decode(Rates.self, forKey: .rates)
    }
}

//All the currencies offered by API
struct Rates: Decodable {
    let BYN: Double
    let EUR: Double?
    let PLN: Double?
    let RUB: Double?
    let UAH: Double?
    let USD: Double?
    
    var ratesDictionary: [String: Double?] {
        let dict = [
            "BYN": BYN,
            "EUR": EUR,
            "PLN": PLN,
            "RUB": RUB,
            "USD": USD,
            "UAH": UAH
        ]
        
        return dict
    }
    
    //Method to make it easier to grab rate of specific currency rate.
    func getRate(of code: String) -> Double {
        return (ratesDictionary[code] ?? 0.0) ?? 0
    }
}
