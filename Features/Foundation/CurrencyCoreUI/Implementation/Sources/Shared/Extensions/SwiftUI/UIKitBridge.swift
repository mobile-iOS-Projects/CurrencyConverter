//
//  UIKitBridge.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 15.12.23.
//

#if os(iOS) || os(visionOS)
import SwiftUI

extension View {
    @MainActor
    public func eraseToAnyUIView() -> UIView {
        return UIHostingConfiguration { self }.makeContentView()
    }
}
#endif
