//
//  View+ViewPresets.swift
//  SAPStart
//
//  Created by Weiss, Alexander on 01.04.22.
//

#if !os(visionOS)
import SwiftUI
import WidgetKit

extension View {
    public func previewDarkTheme() -> some View {
        DarkThemePreview { self }
    }

    public func previewContentSize(_ sizeCategory: ContentSizeCategory) -> some View {
        ContentSizeCategoryPreview(sizeCategory) { self }
    }

    public func previewWidgetFamily(_ widgetFamily: WidgetFamily) -> some View {
        WidgetPreview(widgetFamily) { self }
    }
}
#endif
