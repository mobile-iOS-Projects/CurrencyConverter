//
//  Typography+visionOS.swift
//  SMSCoreUI_visionos
//
//  Created by Schmitt, Frank on 13.10.23.
//

#if os(visionOS)
import SwiftUI
import UIKit

// MARK: - UIFont
extension UIFont {
    /// Retrieve a dynamic font for the given `style` and `weight`
    ///
    /// - Parameters
    ///   - style: The style to retrieve a font for
    ///   - weight: The weight of the font
    /// - Returns: An dynamic UIFont instance
    // swiftformat:disable unusedArguments
    public static func preferredSMSFont(
        for style: UIFont.TextStyle,
        weight: UIFont.Weight = .regular,
        size: CGFloat? = nil
    ) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let descriptor = preferredFont(forTextStyle: style).fontDescriptor
        let defaultSize = descriptor.pointSize
        let fontToScale = UIFont.systemFont(ofSize: size ?? defaultSize, weight: weight)
        return metrics.scaledFont(for: fontToScale)
    }

    /// Retrieve a fixed size font for the given `style` and `weight`
    ///
    /// - Parameters
    ///   - size: The size for the font
    ///   - weight: The weight of the font
    /// - Returns: An fixed sized UIFont instance
    public static func preferredSMSFont(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        UIFont.systemFont(ofSize: size, weight: weight)
    }
}

// MARK: - SwiftUI Font
extension Font {
    /// Retrieve a dynamic font for the given `style` and `weight`
    ///
    /// - Parameters
    ///   - style: The style to retrieve a font for
    ///   - weight: The weight of the font
    /// - Returns: An dynamic Font instance
    public static func preferredSMSFont(for style: TextStyle, weight: Font.Weight? = nil) -> Font {
        let font: Font = .system(style)

        guard let weight else {
            return font
        }

        return font.weight(weight)
    }

    /// Retrieve a fixed size font for the given `style` and `weight`
    ///
    /// - Parameters
    ///   - style: The size for the font
    ///   - weight: The weight of the font
    /// - Returns: An fixed sized Font instance
    public static func preferredStartFont(size: CGFloat, weight: Font.Weight? = nil) -> Font {
        let font: Font = .system(size: size)

        guard let weight else {
            return font
        }

        return font.weight(weight)
    }
}
#endif
