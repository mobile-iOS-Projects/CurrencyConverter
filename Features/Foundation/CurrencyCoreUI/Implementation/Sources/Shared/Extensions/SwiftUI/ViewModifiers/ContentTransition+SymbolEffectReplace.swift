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
        #warning("Remove workaround when dropping iOS16 support")
        if #available(iOS 17.0, watchOS 10, *) {
            content
                .contentTransition(.symbolEffect(.replace, options: .speed(2.0)))
        } else {
            content
        }
    }
}
