//
//  Currency+Extensions.swift
//  ConversionAPI
//
//  Created by Siarhei Runovich on 11.06.24.
//

import Foundation

extension Currency {
    static func placeholder() -> Self {
        Currency(id: UUID().uuidString, code: "USD", rate: 33.88)
    }
}

extension [Currency] {
    static var placeholder: Self {
        (0 ... 6).map { _ in Currency.placeholder() }
    }
}
