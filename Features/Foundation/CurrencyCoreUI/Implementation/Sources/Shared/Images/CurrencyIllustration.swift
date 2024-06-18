//
//  CurrencyIllustration.swift
//  CurrencyCoreUI
//
//  Created by Mikita Halitski on 14/06/2024.
//

import Foundation

/// An object representing a custom SF Symbol
public struct CurrencyIllustration: ExpressibleByStringInterpolation {
    // The name of the symbol in the asset catalog
    let rawValue: String

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

// MARK: - Symbols
extension CurrencyIllustration {
    // A static prefix for the icons
    private static let currencyDirectoryPrefix = "Illustrations"

    // Available custom SFSymbol icons
    public static let simpleConnection: CurrencyIllustration = "\(currencyDirectoryPrefix)"
}

public enum CurrencyIllustrationOption: String {
    case noInternetConnection
}
