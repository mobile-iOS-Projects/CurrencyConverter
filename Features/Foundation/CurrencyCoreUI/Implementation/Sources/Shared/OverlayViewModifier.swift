//
//  OverlayViewModifier.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 14.01.23.
//

import SwiftUI

public struct OverlayViewModifier<EmptyContent>: ViewModifier where EmptyContent: View {
    var showOverlay: Bool
    let overlayContent: () -> EmptyContent

    public func body(content: Content) -> some View {
        if showOverlay {
            content.overlay(overlayContent())
        } else {
            content
        }
    }
}

extension View {
    public func overlay(
        _ showOverlay: Bool,
        overlayContent: @escaping () -> some View
    ) -> some View {
        modifier(OverlayViewModifier(showOverlay: showOverlay, overlayContent: overlayContent))
    }
}
