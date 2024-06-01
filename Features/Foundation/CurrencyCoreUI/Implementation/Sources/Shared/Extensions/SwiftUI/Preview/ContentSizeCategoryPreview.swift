//
//  ContentSizeCategoryPreview.swift
//  SAPStart
//
//  Created by Weiss, Alexander on 01.04.22.
//

import SwiftUI

public struct ContentSizeCategoryPreview<Preview: View>: View {
    private let preview: Preview
    private let sizeCategory: ContentSizeCategory

    public var body: some View {
        preview
            .previewLayout(PreviewLayout.sizeThatFits)
            .environment(\.sizeCategory, sizeCategory)
            .previewDisplayName("Content Size Category: \(sizeCategory)")
    }

    public init(_ sizeCategory: ContentSizeCategory, @ViewBuilder builder: @escaping () -> Preview) {
        self.sizeCategory = sizeCategory
        preview = builder()
    }
}
