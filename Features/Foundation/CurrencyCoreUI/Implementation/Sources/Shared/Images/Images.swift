//
//  Images.swift
//  CurrencyCoreUI
//
//  Created by Mikita Halitski on 14/06/2024.
//

import Foundation
import SwiftUI

extension Image {
    public init(currencyIllustration: CurrencyIllustration, option: CurrencyIllustrationOption) {
        self.init("\(currencyIllustration.rawValue)/\(option.rawValue)", bundle: .current)
    }
}
