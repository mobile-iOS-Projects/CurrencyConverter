//
//  UIImage+SMSSymbol.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 17.05.23.
//

import UIKit

extension UIImage {
    /// Creates an image by using the custom SMS SFSymbol name that’s compatible with the configuration you specify.
    ///
    /// - Parameters:
    ///   - smsSymbol: Name of the custom SMS SFSymbol
    ///   - configuration: The image configuration that you want. Use this parameter to specify traits and other details that
    /// define which variant of the image you want. For example, when requesting a custom symbol image, you can specify whether
    /// you want the thin, regular, or bold image variant.
    public convenience init?(smsSymbol: SMSSymbol, with configuration: UIImage.Configuration? = nil) {
        self.init(named: smsSymbol.rawValue, in: .current, with: configuration)
    }
}
