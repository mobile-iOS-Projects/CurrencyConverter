//
//  Colors.swift
//  CoreUI
//
//  Created by Weiss, Alexander on 30.04.22.
//

#if os(iOS)

import SwiftUI
import UIKit

/// The color style for SAPStart
public typealias SMSColorSwiftUIStyle = Color

// MARK: - SwiftUI Color
extension Color {
    /// Retrieve a color for the given `style`
    ///
    /// - Parameters
    ///   - style: The style to retrieve a color for
    /// - Returns: An dynamic Color instance
    public static func preferredSMSColor(for style: SMSColorSwiftUIStyle) -> Color {
        .black
    }
}

#endif
