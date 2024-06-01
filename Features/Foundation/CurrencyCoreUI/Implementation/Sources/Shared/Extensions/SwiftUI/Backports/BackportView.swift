//
//  BackportView.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 21.08.22.
//

import SwiftUI

/// A namespace for all backport methods
public struct Backport<Content: View> {
    let content: Content
}

extension View {
    /// Namespace for backport methods for older iOS versions
    public var backport: Backport<Self> { Backport(content: self) }
}
