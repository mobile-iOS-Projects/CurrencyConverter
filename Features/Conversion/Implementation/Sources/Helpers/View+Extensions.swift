//
//  View+Extensions.swift
//  Conversion
//
//  Created by Siarhei Runovich on 25.06.24.
//

import SwiftUI

extension View {
    /// Safe Area
    var sfeArea: UIEdgeInsets {
        if let safeArea = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets {
            return safeArea
        }
        
        return .zero
    }
    
    @ViewBuilder
    func offsetY(result: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let minY = $0.frame(in: .scrollView(axis: .vertical)).minY
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                        .onPreferenceChange(OffsetKey.self, perform: { value in
                            result(value)
                        })
                }
            }
    }
}

/// Preference Keys
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
