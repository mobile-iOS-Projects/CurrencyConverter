//
//  SMSObjectItem.swift
//  SMSCoreUI
//
//  Created by Siarhei Runovich on 29.03.24.
//

#if os(iOS) || os(visionOS)

import SwiftUI

// NOTE: This view will be used before the SDK issue(layout and etc.) for the ObjectItem is fixed.
// To configure the infoStack textComponent, the AttributedString text is expected.
// This allows the consumer to set up font, color, highlighted features, etc.
// NOTE: Refactor SMSObjectItem to create a generic variant.
// Task: https://jira.tools.sap/browse/MCOESAPSTART-16066
public struct SMSObjectItem<DetailImage>: View
    where DetailImage: View
{
    // MARK: Environment Properties
    @Environment(\.sizeCategory) private var sizeCategory

    // MARK: Private Properties
    private var appImageSize: CGFloat {
        // Check whether an accessibility font size category is used if not
        sizeCategory.isAccessibilityCategory ? 80 : 40
    }

    private let headlineText: AttributedString?
    private let subheadlineText: AttributedString?
    private let footnoteText: AttributedString?

    private let appImage: Image?
    private let detailImage: DetailImage?

    // MARK: Initialize
    public init(
        headlineText: AttributedString? = nil,
        subheadlineText: AttributedString? = nil,
        footnoteText: AttributedString? = nil,
        appImage: Image? = nil,
        @ViewBuilder detailImage: () -> DetailImage?
    ) {
        self.headlineText = headlineText
        self.subheadlineText = subheadlineText
        self.footnoteText = footnoteText
        self.appImage = appImage
        self.detailImage = detailImage()
    }

    // MARK: Body
    public var body: some View {
        contentLayout(
            contentView()
        )
        .padding(.all, 16)
        .accessibilityElement(children: .ignore)
        // This modifier should handle the tap gesture.
        // It's crucial to ensure that the entire cell is filled with content.
        // Because without it, only the visible content will react to the tap.
        .contentShape(Rectangle())
        #if os(visionOS)
            .hoverEffect()
        #endif
    }
}

// MARK: Subviews
extension SMSObjectItem {
    @ViewBuilder
    private func contentLayout(_ contentView: some View) -> some View {
        if sizeCategory.isAccessibilityCategory {
            VStack(alignment: .leading) {
                contentView
            }
        } else {
            HStack {
                contentView
            }
        }
    }

    @ViewBuilder
    private func contentView() -> some View {
        appImageView
            .padding(.trailing, 12)

        infoStack
            .padding(.trailing, 12)

        detailImageView
    }

    @ViewBuilder
    private var appImageView: some View {
        VStack(spacing: 0) {
            if let appImage {
                appImage
                    .resizable()
                    .frame(width: appImageSize, height: appImageSize)
            }

            if subheadlineText?.description != nil,
               footnoteText?.description != nil,
               !sizeCategory.isAccessibilityCategory
            {
                Spacer()
            }
        }
    }

    @ViewBuilder
    private var infoStack: some View {
        VStack(alignment: .leading, spacing: 4) {
            textComponent(headlineText)
            textComponent(subheadlineText)
            textComponent(footnoteText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    @ViewBuilder
    private var detailImageView: some View {
        VStack(spacing: 0) {
            if let detailImage {
                detailImage
            }

            if subheadlineText?.description != nil,
               footnoteText?.description != nil,
               !sizeCategory.isAccessibilityCategory
            {
                Spacer()
            }
        }
    }
}

// MARK: Helpers
extension SMSObjectItem {
    @ViewBuilder
    private func textComponent(_ text: AttributedString?) -> some View {
        if let text, !text.description.isEmpty {
            Text(text)
                .lineLimit(sizeCategory.isAccessibilityCategory ? nil : 1)
                .truncationMode(.tail)
        }
    }
}

#endif
