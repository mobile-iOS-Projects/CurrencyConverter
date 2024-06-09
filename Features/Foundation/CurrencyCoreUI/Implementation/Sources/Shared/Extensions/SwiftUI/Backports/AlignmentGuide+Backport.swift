//
//  AlignmentGuide+Backport.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 21.08.22.
//

#if os(iOS)

import SwiftUI

extension Backport {
    /// Aligns the list row separator to the leading edge and not the leading text
    ///
    /// - Returns: A view modified with respect to its horizontal alignment according to the computation performed in the method’s
    /// closure.
    @available(iOS, deprecated: 16.0, message: "Remove workaround when dropping iOS15 support")
    @ViewBuilder public func leadingSeparatorListRowAlignment() -> some View {
        if #available(iOS 16, *) {
            content.alignmentGuide(
                .listRowSeparatorLeading
            ) { dimensions in
                dimensions[.leading]
            }
        } else {
            self.content
        }
    }
}

#endif
