//
//  ScrollViewIfNeeded.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 25.04.24.
//

import Foundation
import SwiftUI

/// Wraps the view in a `ScrollView` if needed
struct ScrollViewIfNeeded: ViewModifier {
    func body(content: Content) -> some View {
        ViewThatFits(in: .vertical) {
            content
            ScrollView {
                content
            }
            .scrollIndicators(.hidden)
        }
    }
}

extension View {
    /// Wraps the view in a `ScrollView` if needed
    ///
    /// - Parameters:
    ///   - content: The content to wrap
    /// - Returns: Either the view itself or wrapped in a ScrollView
    public func embeddInScrollViewIfNeeded() -> some View {
        modifier(ScrollViewIfNeeded())
    }
}
