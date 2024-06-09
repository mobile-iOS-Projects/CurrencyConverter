//
//  Typography.swift
//  CoreUI
//
//  Created by Weiss, Alexander on 30.04.22.
//

import SwiftUI

#if os(iOS)

// MARK: - SwiftUI Font
extension Font {
    /// Retrieve a dynamic font for the given `style` and `weight`
    ///
    /// - Parameters
    ///   - style: The style to retrieve a font for
    ///   - weight: The weight of the font
    /// - Returns: An dynamic Font instance
    public static func preferredSMSFont(for style: SAPStartTextStyle, weight: Font.Weight? = nil) -> Font {
        let font: Font = .sapStartFont(forTextStyle: style)

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
        let font: Font = .sapStartFont(fixedSize: size)

        guard let weight else {
            return font
        }

        return font.weight(weight)
    }
}

extension Font {
    public static func preferredSMSFont(
        for style: UIFont.TextStyle,
        weight: UIFont.Weight = .regular,
        sizeCategory: ContentSizeCategory,
        isItalic: Bool = false
    ) -> Font {
        let font = switch sizeCategory {
        case .extraSmall:
            fontForStyle(style, weight: weight, styleSizes: StyleSizes.extraSmall, isItalic: isItalic)
        case .small:
            fontForStyle(style, weight: weight, styleSizes: StyleSizes.small, isItalic: isItalic)
        case .medium:
            fontForStyle(style, weight: weight, styleSizes: StyleSizes.medium, isItalic: isItalic)
        case .large:
            fontForStyle(style, weight: weight, styleSizes: StyleSizes.large, isItalic: isItalic)
        case .extraLarge:
            fontForStyle(style, weight: weight, styleSizes: StyleSizes.extraLarge, isItalic: isItalic)
        case .extraExtraLarge:
            fontForStyle(style, weight: weight, styleSizes: StyleSizes.extraExtraLarge, isItalic: isItalic)
        case .extraExtraExtraLarge:
            fontForStyle(style, weight: weight, styleSizes: StyleSizes.extraExtraExtraLarge, isItalic: isItalic)
        case .accessibilityMedium,
             .accessibilityLarge,
             .accessibilityExtraLarge,
             .accessibilityExtraExtraLarge,
             .accessibilityExtraExtraExtraLarge:
            fontForStyle(style, weight: weight, styleSizes: StyleSizes.accessibility, isItalic: isItalic)
        @unknown default:
            UIFont.systemFont(ofSize: 12)
        }
        return Font(font)
    }

    static func fontForStyle(
        _ style: UIFont.TextStyle,
        weight: UIFont.Weight,
        styleSizes: [UIFont.TextStyle: CGFloat],
        isItalic: Bool
    ) -> UIFont {
        if let size = styleSizes[style] {
            return UIFont.systemFont(ofSize: 12)
        }
        return   UIFont.systemFont(ofSize: 12)
    }
}

// Credit: https://github.com/SAP/cloud-sdk-ios-fiori/blob/main/Sources/FioriThemeManager/72-Fonts/Font%2BFiori.swift
extension Font {
    /// Fiori (72) fonts
    ///
    /// Supported attributes: `Regular`, `Italic`, `Light`, `Bold`, `BoldItalic`, `Black`, `Condensed`, `CondensedBold`.
    ///
    /// - Parameters:
    ///   - sapStartTextStyle: Text style
    /// - Returns: A scaled font for this text style
    fileprivate static func sapStartFont(forTextStyle sapStartTextStyle: Font.SAPStartTextStyle) -> Font {
        guard UIFont.familyNames.contains("72") else {
            return Font.system(sapStartTextStyle.textStyle)
        }

        return Font.custom("72", size: sapStartTextStyle.pointSize, relativeTo: sapStartTextStyle.textStyle)
    }

    /// Fiori (72) fonts
    ///
    /// Supported attributes: `Regular`, `Italic`, `Light`, `Bold`, `BoldItalic`, `Black`, `Condensed`, `CondensedBold`.
    ///
    /// - Parameters:
    ///   - fixedSize: Size of the font
    /// - Returns: A font with fixed size
    fileprivate static func sapStartFont(fixedSize: CGFloat) -> Font {
        guard UIFont.familyNames.contains("72") else {
            return Font.system(size: fixedSize)
        }

        return Font.custom("72", fixedSize: fixedSize)
    }

    /// Fiori (72) condensed fonts
    ///
    /// Supported attributes: `Regular`, `Italic`, `Light`, `Bold`, `BoldItalic`, `Black`, `Condensed`, `CondensedBold`.
    ///
    /// - Parameters:
    ///   - sapStartTextStyle: Text style
    /// - Returns: A scaled condensed font for this text style
    fileprivate static func sapStartFontCondensed(forTextStyle sapStartTextStyle: Font.SAPStartTextStyle) -> Font {
        guard UIFont.familyNames.contains("72") else {
            return Font.system(sapStartTextStyle.textStyle)
        }

        return Font.custom("72-Condensed", size: sapStartTextStyle.pointSize, relativeTo: sapStartTextStyle.textStyle)
    }

    /// Fiori (72) condensed fonts
    ///
    /// Supported attributes: `Regular`, `Italic`, `Light`, `Bold`, `BoldItalic`, `Black`, `Condensed`, `CondensedBold`.
    ///
    /// - Parameters:
    ///   - fixedSize: Size of the font
    /// - Returns: A condensed font with fixed size.
    fileprivate static func sapStartFontCondensed(fixedSize: CGFloat) -> Font {
        guard UIFont.familyNames.contains("72") else {
            return Font.system(size: fixedSize)
        }

        return Font.custom("72-Condensed", fixedSize: fixedSize)
    }
}

extension Font {
    // Mapping text style to font size for each size category
    // According HIG https://developer.apple.com/design/human-interface-guidelines/foundations/typography/
    fileprivate enum StyleSizes {
        static let extraSmall: [UIFont.TextStyle: CGFloat] =
            [
                .caption1: 11,
                .caption2: 11,
                .footnote: 12,
                .subheadline: 12,
                .callout: 13,
                .body: 14,
                .headline: 14,
                .title3: 17,
                .title2: 19,
                .title1: 25,
                .largeTitle: 31,
            ]

        static let small: [UIFont.TextStyle: CGFloat] =
            [
                .caption1: 11,
                .caption2: 11,
                .footnote: 12,
                .subheadline: 13,
                .callout: 14,
                .body: 15,
                .headline: 15,
                .title3: 18,
                .title2: 20,
                .title1: 26,
                .largeTitle: 32,
            ]

        static let medium: [UIFont.TextStyle: CGFloat] =
            [
                .caption1: 11,
                .caption2: 11,
                .footnote: 12,
                .subheadline: 14,
                .callout: 15,
                .body: 16,
                .headline: 16,
                .title3: 19,
                .title2: 21,
                .title1: 27,
                .largeTitle: 33,
            ]

        static let large: [UIFont.TextStyle: CGFloat] = [
            .caption1: 11,
            .caption2: 12,
            .footnote: 13,
            .subheadline: 15,
            .callout: 16,
            .body: 17,
            .headline: 17,
            .title3: 20,
            .title2: 22,
            .title1: 28,
            .largeTitle: 34,
        ]

        static let extraLarge: [UIFont.TextStyle: CGFloat] = [
            .caption1: 13,
            .caption2: 14,
            .footnote: 15,
            .subheadline: 17,
            .callout: 18,
            .body: 19,
            .headline: 17,
            .title3: 22,
            .title2: 24,
            .title1: 30,
            .largeTitle: 36,
        ]

        static let extraExtraLarge: [UIFont.TextStyle: CGFloat] = [
            .caption1: 15,
            .caption2: 16,
            .footnote: 17,
            .subheadline: 19,
            .callout: 20,
            .body: 21,
            .headline: 21,
            .title3: 24,
            .title2: 26,
            .title1: 32,
            .largeTitle: 38,
        ]

        static let extraExtraExtraLarge: [UIFont.TextStyle: CGFloat] = [
            .caption1: 17,
            .caption2: 18,
            .footnote: 19,
            .subheadline: 21,
            .callout: 22,
            .body: 23,
            .headline: 23,
            .title3: 26,
            .title2: 28,
            .title1: 34,
            .largeTitle: 40,
        ]

        static let accessibility: [UIFont.TextStyle: CGFloat] = [
            .caption1: 20,
            .caption2: 22,
            .footnote: 23,
            .subheadline: 25,
            .callout: 26,
            .body: 28,
            .headline: 28,
            .title3: 31,
            .title2: 34,
            .title1: 38,
            .largeTitle: 44,
        ]
    }
}

// MARK: - SAPStartTextStyle
extension Font {
    /// Fiori text style.
    public enum SAPStartTextStyle: CaseIterable {
        case largeTitle
        case title1, title2, title3
        case headline, subheadline
        case body
        case callout
        case footnote
        case caption1, caption2
        case KPI, largeKPI

        var textStyle: TextStyle {
            switch self {
            case .largeTitle:
                return .largeTitle
            case .title1:
                return .title
            case .title2:
                return .title2
            case .title3:
                return .title3
            case .headline:
                return .headline
            case .body:
                return .body
            case .callout:
                return .callout
            case .subheadline:
                return .subheadline
            case .footnote:
                return .footnote
            case .caption1:
                return .caption
            case .caption2:
                return .caption2
            case .KPI, .largeKPI:
                return .largeTitle
            }
        }

        var pointSize: CGFloat {
            switch self {
            case .largeTitle:
                return 34
            case .title1:
                return 28
            case .title2:
                return 22
            case .title3:
                return 20
            case .headline:
                return 17
            case .body:
                return 17
            case .callout:
                return 16
            case .subheadline:
                return 15
            case .footnote:
                return 13
            case .caption1:
                return 12
            case .caption2:
                return 11
            case .largeKPI:
                return 48
            case .KPI:
                return 36
            }
        }
    }
}
#endif
