//
//  ContentTransition+SymbolEffectReplace.swift
//  SMSCoreUI
//
//  Created by Siarhei Runovich on 10.04.24.
//

import SwiftUI

extension View {
    /// Adds symbol effect `.replace` as a content transition.
    ///
    /// - Returns: A view modified with content transition
    /// symbol effect `.replace` for iOS17+. Fall back to no content transition.
    public func contentTransitionSymbolEffectReplace() -> some View {
        self.modifier(ContentReplaceSymbolEffectReplace())
    }
}

private struct ContentReplaceSymbolEffectReplace: ViewModifier {
    func body(content: Content) -> some View {
        content
            .contentTransition(.symbolEffect(.replace, options: .speed(2.0)))
    }
}
