//
//  Colors.swift
//  CurrencyCoreUI
//
//  Created by Mikita Halitski on 09/06/2024.
//

import SwiftUI

extension Color {
    /// Method that returns color for specified style
    /// - Parameter style: style which you want to apply
    /// - Returns: color
    public static func preferredColor(for style: ColorStyle) -> Color {
        return style.color()
    }
}
