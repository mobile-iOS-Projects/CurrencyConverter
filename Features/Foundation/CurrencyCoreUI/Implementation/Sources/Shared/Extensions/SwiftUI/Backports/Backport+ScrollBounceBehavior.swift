//
//  Backport+ScrollBounceBehavior.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 06.02.24.
//

import SwiftUI

extension Backport {
    /// Configures the bounce behavior of scrollable views along the specified axis
    ///
    /// - Attention: This is just the backported version of the original one. On
    ///  iOS versions lower than 16.4 and watchOS versions lower than 9.4 this modifier has no effect.
    ///
    /// - Parameters:
    ///   - behavior: The bounce behavior to apply to any scrollable views within the configured view.
    /// - Returns: A view that’s configured with the specified scroll bounce behavior.
    @available(watchOS, deprecated: 9.4, message: "Remove workaround when dropping watchOS 9 support")
    @available(iOS, deprecated: 16.4, message: "Remove workaround when dropping iOS 16 support")
    @ViewBuilder public func scrollBounceBehavior(_ behavior: SMSScrollBounceBehaviour) -> some View {
        if #available(iOS 16.4, watchOS 9.4, visionOS 1.0, *) {
            let bounceBehavior: ScrollBounceBehavior = switch behavior {
            case .always:
                .always
            case .automatic:
                .automatic
            case .basedOnSize:
                .basedOnSize
            }

            content.scrollBounceBehavior(bounceBehavior)
        } else {
            content
        }
    }
}

@available(watchOS, deprecated: 9.4, message: "Remove workaround when dropping watchOS 9 support")
@available(iOS, deprecated: 16.4, message: "Remove workaround when dropping iOS 16 support")
public enum SMSScrollBounceBehaviour {
    case always
    case automatic
    case basedOnSize
}
