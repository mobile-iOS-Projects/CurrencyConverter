//
//  SMSIconFontModelMappings.swift
//  SMSCoreUI
//
//  Created by Weiss, Alexander on 14.07.22.
//

import Foundation
import SMSCore

// MARK: - SMSIconFontSet
public struct SMSIconFontSet {
    public let fontID: String?
    public let name: String
    public let icons: [String: String]

    // swiftlint:disable:next large_tuple
    public var iconURLs: [(url: URL, name: String, value: UInt32)] {
        self.icons.compactMap { element in

            var urlComponents = URLComponents()
            urlComponents.scheme = "sap-icon"
            if let fontID {
                urlComponents.host = fontID
                urlComponents.path = "/\(element.key)"
            } else {
                urlComponents.host = element.key
            }

            guard let url = urlComponents.url, let scalar = element.value.unicodeScalars.first else {
                return nil
            }

            return (url: url, name: element.key, value: scalar.value)
        }
    }
}

// MARK: - SMSIconFontCharacter
typealias SMSIconFontCharacter = (unicodeChar: String?, fontName: SMSIconFontName)
