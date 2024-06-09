//
//  SectionSeparatorVisibility.swift
//  SMSCoreUI
//
//  Created by Steinmetz, Conrad on 19.07.22.
//

#if os(iOS)

import SwiftUI

extension Backport {
    @available(iOS, deprecated: 15.0, message: "Remove workaround when dropping iOS14 support")
    @ViewBuilder public func sectionSeparator(isVisible: Bool) -> some View {
        if #available(iOS 15.0, *) {
            content.modifier(SectionSeparatorVisibility(visibility: isVisible ? .visible : .hidden))
        } else {
            content
        }
    }
}

@available(iOS 15.0, *)
public struct SectionSeparatorVisibility: ViewModifier {
    var visibility: Visibility

    public func body(content: Content) -> some View {
        content.listSectionSeparator(visibility)
    }
}

#endif
