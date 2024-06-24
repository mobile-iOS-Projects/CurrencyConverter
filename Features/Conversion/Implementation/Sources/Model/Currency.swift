//
//  Currency.swift
//  ConversionAPI
//
//  Created by Siarhei Runovich on 10.06.24.
//

import Foundation

public struct Currency: Identifiable, Equatable, Hashable {
    public var id: String

    let code: String
    let rate: Double

    var flag: String { CurrencyCountryType(rawValue: code)?.emoji ?? "" }
    var fullName: String { CurrencyCountryType(rawValue: code)?.fullName ?? "" }
    var symbol: String { CurrencyCountryType(rawValue: code)?.symbol ?? "" }
}
