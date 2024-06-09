//
//  SMSColorStyle+visionOS.swift
//  SMSCoreUI_visionos
//
//  Created by Schmitt, Frank on 13.10.23.
//

#if os(visionOS)

public typealias SMSColorSwiftUIStyle = SMSColorStyle

public enum SMSColorStyle: String, CaseIterable {
    case primaryLabel
    case primaryBackground
    case primaryGroupedBackground
    case secondaryLabel
    case secondaryGroupedBackground
    case tertiaryLabel
    case quaternaryLabel

    case positiveLabel
    case negativeLabel
    case criticalLabel

    case tintColor
    case tintColor2

    case green6 // Debug Menu

    case baseWhite
    case base2

    case contrastElement

    case red1
    case red6
    case grey1
    case grey3
    case grey4
    case grey5

    case indigo5

    case blue5
    case blue6

    case separator
    case separatorOpaque

    case accentBackground1
    case accentBackground2
    case accentBackground3
    case accentBackground4
    case accentBackground5
    case accentBackground6
    case accentBackground7
    case accentBackground8
    case accentBackground9
    case accentBackground10

    case accentLabel1
    case accentLabel2
    case accentLabel3
    case accentLabel4
    case accentLabel5
    case accentLabel6
    case accentLabel7
    case accentLabel8
    case accentLabel9
    case accentLabel10

    case accent1
}

extension SMSColorStyle: CustomDebugStringConvertible {
    public var debugDescription: String {
        "\(self.rawValue)"
    }
}

#endif
