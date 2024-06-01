//
//  Colors+visionOS.swift
//  SMSCoreUI_ios
//
//  Created by Schmitt, Frank on 13.10.23.
//

#if os(visionOS)
import SwiftUI

// MARK: - Color
extension Color {
    /// Retrieve a color for the given `style`
    ///
    /// - Parameters
    ///   - style: The style to retrieve a color for
    /// - Returns: An Color instance
    public static func preferredSMSColor(for style: SMSColorStyle) -> Color {
        switch style {
        case .primaryLabel:
            return .primary
        case .primaryBackground:
            return .white
        case .primaryGroupedBackground:
            return .white
        case .secondaryLabel:
            return .secondary
        case .secondaryGroupedBackground:
            return .white
        case .tertiaryLabel:
            return .secondary
        case .quaternaryLabel:
            return .secondary
        case .positiveLabel:
            return .green
        case .negativeLabel:
            return .red
        case .criticalLabel:
            return .orange
        case .tintColor:
            return .cyan
        case .tintColor2:
            return .cyan
        case .base2:
            return .black
        case .red1:
            return .red
        case .red6:
            return .red
        case .green6: // Debug Menu
            return .green
        case .grey1:
            return .gray
        case .grey3:
            return .gray
        case .grey4:
            return .gray
        case .grey5:
            return .gray
        case .separator:
            return Color(uiColor: .separator)
        case .separatorOpaque:
            return Color(uiColor: .separator)
        case .baseWhite:
            return .white
        case .blue5:
            return .blue
        case .blue6:
            return .blue
        case .indigo5:
            return .purple
        case .accentBackground1:
            return .yellow
        case .accentBackground2:
            return .red
        case .accentBackground3:
            return .pink
        case .accentBackground4:
            return .purple
        case .accentBackground5:
            return .blue
        case .accentBackground6:
            return .blue
        case .accentBackground7:
            return .mint
        case .accentBackground8:
            return .green
        case .accentBackground9:
            return .purple
        case .accentBackground10:
            return .gray
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
        case .contrastElement:
            return .init(uiColor: .darkGray)
        case .accent1:
            return .yellow
        }
    }
}
#endif
