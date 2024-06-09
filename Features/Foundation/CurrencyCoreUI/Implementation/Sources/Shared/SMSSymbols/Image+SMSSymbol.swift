//
//  Image+SMSSymbol.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 17.02.23.
//

import Foundation
import SwiftUI

extension Image {
    /// Creates a labeled image that you can use as content for controls.
    ///
    /// - Parameters
    ///   - smsSymbol: Name of the custom SMS SFSymbol
    public init(smsSymbol: SMSSymbol) {
        self.init(smsSymbol.rawValue, bundle: .current)
    }
}
