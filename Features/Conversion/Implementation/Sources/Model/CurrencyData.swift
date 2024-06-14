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
