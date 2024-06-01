//
//  UIColor+visionOS.swift
//  SMSCoreUI_visionos
//
//  Created by Schmitt, Frank on 13.10.23.
//

#if os(visionOS)
import UIKit

// MARK: - Color
extension UIColor {
    /// Retrieve a color for the given `style`
    ///
    /// - Parameters
    ///   - style: The style to retrieve a color for
    /// - Returns: An UIColor instance
    public static func preferredSMSColor(for style: SMSColorStyle) -> UIColor {
        switch style {
        case .primaryLabel:
            return .label
        case .primaryBackground:
            return .white
        case .primaryGroupedBackground:
            return .white
        case .secondaryLabel:
            return .secondaryLabel
        case .secondaryGroupedBackground:
            return .white
        case .tertiaryLabel:
            return .secondaryLabel
        case .quaternaryLabel:
            return .secondaryLabel
        case .positiveLabel:
            return .systemGreen
        case .negativeLabel:
            return .systemRed
        case .criticalLabel:
            return .systemOrange
        case .tintColor:
            return .systemCyan
        case .tintColor2:
            return .systemCyan
        case .base2:
            return .black
        case .red1:
            return .systemRed
        case .red6:
            return .systemRed
        case .green6: // Debug Menu
            return .systemGreen
        case .grey1:
            return .systemGray
        case .grey3:
            return .systemGray3
        case .grey4:
            return .systemGray
        case .grey5:
            return .systemGray
        case .separator:
            return .separator
        case .separatorOpaque:
            return .separator
        case .indigo5:
            return .systemPurple
        case .blue5:
            return .systemBlue
        case .blue6:
            return .systemBlue
        case .accentBackground1:
            return .systemYellow
        case .accentBackground2:
            return .systemRed
        case .accentBackground3:
            return .init(.pink)
        case .accentBackground4:
            return .systemPurple
        case .accentBackground5:
            return .systemBlue
        case .accentBackground6:
            return .systemBlue
        case .accentBackground7:
            return .init(.mint)
        case .accentBackground8:
            return .systemGreen
        case .accentBackground9:
            return .systemPurple
        case .accentBackground10:
            return .systemGray
        case .accentLabel1:
            return .black
        case .accentLabel2:
            return .black
        case .accentLabel3:
            return .black
        case .accentLabel4:
            return .black
        case .accentLabel5:
            return .black
        case .accentLabel6:
            return .black
        case .accentLabel7:
            return .black
        case .accentLabel8:
            return .black
        case .accentLabel9:
            return .black
        case .accentLabel10:
            return .black
        case .baseWhite:
            return .white
        case .contrastElement:
            return .darkGray
        case .accent1:
            return .systemYellow
        }
    }
}

#endif
