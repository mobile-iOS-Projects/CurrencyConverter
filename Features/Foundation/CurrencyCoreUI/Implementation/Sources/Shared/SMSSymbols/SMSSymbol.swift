//
//  SMSSymbol.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 17.02.23.
//

import Foundation

/// An object representing a custom SF Symbol
public struct SMSSymbol: ExpressibleByStringInterpolation {
    // The name of the symbol in the asset catalog
    let rawValue: String

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

// MARK: - Symbols
extension SMSSymbol {
    // A static prefix for the icons
    private static let smsPrefix = "sms"
    private static let fioriPrefix = "fiori"

    // Available custom SFSymbol icons
    public static let tray: SMSSymbol = "\(smsPrefix).tray"
    public static let triangleFillUp: SMSSymbol = "\(smsPrefix).triangle.fill.up"
    public static let triangleFillDown: SMSSymbol = "\(smsPrefix).triangle.fill.down"
    public static let internetIcon: SMSSymbol = "\(smsPrefix).internet.browser"

    public static let fioriBiometricFace: SMSSymbol = "\(fioriPrefix).biometric.face"
    public static let fioriDocumentText: SMSSymbol = "\(fioriPrefix).document.text"
    public static let fioriLocked: SMSSymbol = "\(fioriPrefix).locked"
    public static let fioriMarketingCampaign: SMSSymbol = "\(fioriPrefix).marketing.campaign"
    public static let fioriNotification3: SMSSymbol = "\(fioriPrefix).notification.3"
    public static let fioriNotification4: SMSSymbol = "\(fioriPrefix).notification.4"
    public static let fioriSourceCode: SMSSymbol = "\(fioriPrefix).source.code"
    public static let fioriSysHelp: SMSSymbol = "\(fioriPrefix).sys.help"
    public static let fioriSysEnter: SMSSymbol = "\(fioriPrefix).sys.enter"
    public static let fioriUpload: SMSSymbol = "\(fioriPrefix).upload"
    public static let fioriOverflow: SMSSymbol = "\(fioriPrefix).overflow"
    public static let fioriHome: SMSSymbol = "\(fioriPrefix).home"
    public static let fioriFolder: SMSSymbol = "\(fioriPrefix).folder"
    public static let fioriInbox: SMSSymbol = "\(fioriPrefix).inbox"
    public static let fioriDisplayMore: SMSSymbol = "\(fioriPrefix).display.more"
    public static let fioriHistory: SMSSymbol = "\(fioriPrefix).history"
    public static let fioriConnected: SMSSymbol = "\(fioriPrefix).connected"
    public static let fioriError: SMSSymbol = "\(fioriPrefix).error"
    public static let fioriTimeFill: SMSSymbol = "\(fioriPrefix).time.fill"
    public static let fioriMessageWarning: SMSSymbol = "\(fioriPrefix).message.warning"
}
