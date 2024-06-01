//
//  Copyable.swift
//  SMSCoreUI
//
//  Created by Schmitt, Frank on 01.10.22.
//

#if os(iOS) || os(visionOS)

import Foundation
import SwiftUI

/// Use this modifier to enable a view's content to become copyable to the pasteboard.
///
/// In the example below, the modifier adds a button behind the ``Text`` and  takes `myText`
/// as value which will be added to the pasteboard on every tap:
///
///		let myText = "Hello World"
///     Text(myText)
///         .clipboardCopyable(value: myText)
///
/// - Parameters:
///  - value: The value being added to the pasteboard.
///
/// - Returns: A view with an 'add to pasteboard' button next to it.
extension View {
    @ViewBuilder public func clipboardCopyable(value: String) -> some View {
        self.modifier(Copyable(value: value))
    }
}

private struct Copyable: ViewModifier {
    var value: String

    func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            Button {
                UIPasteboard.general.string = value
                #if os(iOS)
//                SMSToastMessage.show(
//                    message: "'\(value)' was added to clipboard",
//                    icon: UIImage(systemName: "checkmark.square.fill"),
//                    maxNumberOfLines: 5
//                )
                #endif
            } label: {
                if #available(iOS 16.0, *) {
                    Image(systemName: "list.clipboard")
                } else {
                    Image(systemName: "doc.on.doc")
                }
            }
        }
    }
}

#endif
