//
//  DarkThemePreview.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 13.02.23.
//

import SwiftUI

public struct DarkThemePreview<Preview: View>: View {
    private let preview: Preview

    public var body: some View {
        preview
            .previewLayout(PreviewLayout.sizeThatFits)
        #if os(iOS) || os(visionOS)
            .background(Color(.systemBackground))
        #endif
            .environment(\.colorScheme, .dark)
            .previewDisplayName("Dark Theme")
    }

    public init(@ViewBuilder builder: @escaping () -> Preview) {
        preview = builder()
    }
}
