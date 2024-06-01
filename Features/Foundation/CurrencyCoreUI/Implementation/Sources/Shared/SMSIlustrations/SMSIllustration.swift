//
//  SMSIllustration.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 17.11.23.
//

import Foundation

/// An object representing a custom SF Symbol
public struct SMSIllustration: ExpressibleByStringInterpolation {
    // The name of the symbol in the asset catalog
    let rawValue: String

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}

// MARK: - Symbols
extension SMSIllustration {
    // A static prefix for the icons
    private static let smsDirectoryPrefix = "SMSIllustrations"

    // Available custom SFSymbol icons
    public static let simpleBell: SMSIllustration = "\(smsDirectoryPrefix)/simple_bell"
    public static let simpleConnection: SMSIllustration = "\(smsDirectoryPrefix)/simple_connection"
    public static let simpleEmptyDoc: SMSIllustration = "\(smsDirectoryPrefix)/simple_empty_doc"
    public static let simpleEmptyList: SMSIllustration = "\(smsDirectoryPrefix)/simple_empty_list"
    public static let simpleMagnifier: SMSIllustration = "\(smsDirectoryPrefix)/simple_magnifier"
    public static let simpleNotFoundMagnifier: SMSIllustration = "\(smsDirectoryPrefix)/simple_not_found_magnifier"
    public static let simpleReload: SMSIllustration = "\(smsDirectoryPrefix)/simple_reload"
    public static let simpleTask: SMSIllustration = "\(smsDirectoryPrefix)/simple_task"
}

// swiftlint:disable identifier_name
public enum SMSIllustrationVariant: String {
    case xxs
    case xs
    #if os(iOS) || os(visionOS)
    case s
    case m
    case l
    case xl
    #endif
}

// swiftlint:enable identifier_name
