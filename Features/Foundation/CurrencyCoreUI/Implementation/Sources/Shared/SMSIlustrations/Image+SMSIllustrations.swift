//
//  Image+SMSIllustrations.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 17.11.23.
//

import Foundation
import SwiftUI

extension Image {
    /// Creates a labeled image that you can use as content for controls.
    ///
    /// - Parameters
    ///   - smsIllustration: Name of the illustration
    ///   - variant: Variant of the illustration
    public init(smsIllustration: SMSIllustration, variant: SMSIllustrationVariant) {
        self.init("\(smsIllustration.rawValue)/\(variant.rawValue)", bundle: .current)
    }
}
