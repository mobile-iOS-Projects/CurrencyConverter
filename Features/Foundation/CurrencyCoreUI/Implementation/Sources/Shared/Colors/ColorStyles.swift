//
//  ColorStyles.swift
//  CurrencyCoreUI
//
//  Created by Mikita Halitski on 09/06/2024.
//

import Foundation
import SwiftUI

public enum ColorStyle {
    case purpleTest
    case redTest
    case greenTest

    /// Method to get the corresponding Color
    /// - Returns: color
    public func color() -> Color {
        switch self {
        case .purpleTest:
            return ColorStyle.colorFromHex("#800080")
        case .redTest:
            return ColorStyle.colorFromRGB(red: 255, green: 0, blue: 0)
        case .greenTest:
            return ColorStyle.colorFromHex("#00FF00")
        }
    }
}

// MARK: - Helper methods
private extension ColorStyle {
    /// Static method to create Color from hexadecimal string
    /// - Parameter hex: hex value of a color
    /// - Returns: color
    static func colorFromHex(_ hex: String) -> Color {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        return Color(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: Double(alpha) / 255
        )
    }

    /// Static method to create Color from RGB values
    /// - Parameters:
    ///   - red: red value
    ///   - green: green value
    ///   - blue: blue value
    /// - Returns: color
    static func colorFromRGB(red: Int, green: Int, blue: Int) -> Color {
        return Color(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: 1.0
        )
    }
}
