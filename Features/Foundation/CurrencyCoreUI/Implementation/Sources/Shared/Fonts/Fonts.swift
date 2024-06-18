//
//  Fonts.swift
//  CurrencyCoreUI
//
//  Created by Mikita Halitski on 12/06/2024.
//

import Foundation
import SwiftUI

extension Font {
    public static func applyFontWith(name: Fonts, fontSize: CGFloat) -> Font {
        return .custom(name.rawValue, size: fontSize)
    }
}

public enum Fonts: String {
    case tiny5 = "Tiny5"
    case sfBold = "SFProDisplay-Bold"
}
