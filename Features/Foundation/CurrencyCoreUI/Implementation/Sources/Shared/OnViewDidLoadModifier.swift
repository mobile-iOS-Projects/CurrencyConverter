//
//  OnViewDidLoadModifier.swift
//  CurrencyCoreUI
//
//  Created by Siarhei Runovich on 20.06.24.
//

import SwiftUI

extension View {
    public func onViewDidLoad(perform action: @escaping () -> Void) -> some View {
        self.modifier(OnViewDidLoadModifier(perform: action))
    }
}

struct OnViewDidLoadModifier: ViewModifier {
    let perform: () -> Void
    @State private var hasAppeared = false

    func body(content: Content) -> some View {
        content.onAppear {
            if !self.hasAppeared {
                self.perform()
                self.hasAppeared = true
            }
        }
    }
}
