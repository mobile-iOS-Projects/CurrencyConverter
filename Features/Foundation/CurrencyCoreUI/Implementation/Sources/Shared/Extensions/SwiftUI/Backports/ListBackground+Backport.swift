//
//  ListBackground+Backport.swift
//  SMSCoreUI
//
//  Created by Yahor Rynkevich on 30/09/2022.
//

#if os(iOS)

import SwiftUI

extension Backport {
    /// Make background clear in List view
    ///
    /// - Returns: A view modified with clear background
    @available(iOS, deprecated: 16.0, message: "Remove workaround when dropping iOS15 support")
    @ViewBuilder public func makeListBackgroundClear() -> some View {
        if #available(iOS 16, *) {
            content.scrollContentBackground(.hidden)
        } else {
            content.onAppear {
                UITableView.appearance().backgroundColor = .clear
            }
        }
    }
}

#endif
