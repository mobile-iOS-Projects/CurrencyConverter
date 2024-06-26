//
//  SafeArea+Extension.swift
//  CurrencyCoreUI
//
//  Created by Siarhei Runovich on 25.06.24.
//

#if os(iOS) || os(visionOS)
import SwiftUI

extension View {
    private func safeAreaInsets() -> UIEdgeInsets? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        return windowScene.windows.first?.safeAreaInsets
    }
}

public extension View {
    var safeArea: UIEdgeInsets {
        return safeAreaInsets() ?? .zero
    }
}
#endif
