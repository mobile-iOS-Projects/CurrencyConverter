//
//  WidgetPreview.swift
//  SAPStartWidgetExtension
//
//  Created by Weiss, Alexander on 01.04.22.
//

#if !os(visionOS)
import SwiftUI
import WidgetKit

public struct WidgetPreview<Preview: View>: View {
    private let preview: Preview
    private let widgetFamily: WidgetFamily

    public var body: some View {
        preview
            .previewLayout(PreviewLayout.sizeThatFits)
            .previewContext(WidgetPreviewContext(family: widgetFamily))
    }

    public init(_ widgetFamily: WidgetFamily, @ViewBuilder builder: @escaping () -> Preview) {
        self.widgetFamily = widgetFamily
        preview = builder()
    }
}
#endif
