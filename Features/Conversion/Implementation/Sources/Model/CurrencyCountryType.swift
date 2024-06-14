//
//  CurrencyCountryType.swift
//  Conversion
//
//  Created by Siarhei Runovich on 10.06.24.
//

import Foundation

enum CurrencyCountryType: String, CaseIterable {
    case unitedStatesDollar = "USD"
    case euro = "EUR"
    case belarusianRuble = "BYN"
    case russianRuble = "RUB"
    case polishZloty = "PLN"
    case ucrainianHryvnia = "UAH"
}

extension CurrencyCountryType {
    var fullName: String {
        switch self {
        case .belarusianRuble:
            "Belarusian ruble"
        case .unitedStatesDollar:
            "US dollar"
        case .euro:
            "Euro"
        case .russianRuble:
            "Russian ruble"
        case .polishZloty:
            "Polish zloty"
        case .ucrainianHryvnia:
            "Ukrainian hryvnia"
        }
    }

    var emoji: String {
        switch self {
        case .belarusianRuble:
            "🇧🇾"
        case .unitedStatesDollar:
            "🇺🇸"
        case .euro:
            "🇪🇺"
        case .russianRuble:
            "🇷🇺"
        case .polishZloty:
            "🇵🇱"
        case .ucrainianHryvnia:
            "🇺🇦"
        }
    }

    var symbol: String {
        switch self {
        case .belarusianRuble:
            "Br"
        case .unitedStatesDollar:
            "$"
        case .euro:
            "€"
        case .russianRuble:
            "₽"
        case .polishZloty:
            "zł"
        case .ucrainianHryvnia:
            "₴"
        }
    }
}
