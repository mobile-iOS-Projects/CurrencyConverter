////
////  SMSButtonStyle.swift
////  SMSCoreUI
////
////  Created by Mikita Halitski on 10/04/2023.
////
//
//#if os(iOS) || os(visionOS)
//import Foundation
//import SwiftUI
//
///// The buttons label edge insets, shared acrross different button styles
//fileprivate var buttonLabelEdgeInsets: EdgeInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
//
//// MARK: - Plain Button Style
//public struct SMSPlainButtonStyle: ButtonStyle {
//    @Environment(\.isEnabled) var isEnabled
//    let foregroundDefaultColor: Color
//    let foregroundTappedColor: Color
//    let disabledColor: Color
//
//    public func makeBody(configuration: Configuration) -> some View {
//        if isEnabled {
//            self.enabled(for: configuration)
//        } else {
//            self.disabled(for: configuration)
//        }
//    }
//
//    @ViewBuilder
//    private func enabled(for configuration: Configuration) -> some View {
//        configuration.label
//            .padding(buttonLabelEdgeInsets)
//            .foregroundStyle(configuration.isPressed ? foregroundTappedColor : foregroundDefaultColor)
//    }
//
//    @ViewBuilder
//    private func disabled(for configuration: Configuration) -> some View {
//        configuration.label
//            .padding(buttonLabelEdgeInsets)
//            .foregroundStyle(disabledColor)
//    }
//}
//
//// MARK: - Outline Button Style
//@available(*, deprecated, message: "Outline style is not supported any longer. Please use a different one")
//public struct SMSOutlinedButtonStyle: ButtonStyle {
//    @Environment(\.isEnabled) var isEnabled
//    let foregroundDefaultColor: Color
//    let foregroundTappedColor: Color
//    let backgroundDefaultColor: Color
//    let backgroundTappedColor: Color
//    let disabledForegroundColor: Color
//    let disabledBackgroundColor: Color
//
//    public func makeBody(configuration: Configuration) -> some View {
//        if isEnabled {
//            self.enabled(for: configuration)
//        } else {
//            self.disabled(for: configuration)
//        }
//    }
//
//    @ViewBuilder
//    private func enabled(for configuration: Configuration) -> some View {
//        configuration.label
//            .padding(buttonLabelEdgeInsets)
//            .background(configuration.isPressed ? backgroundTappedColor : backgroundDefaultColor)
//            .cornerRadius(8)
//            .foregroundColor(configuration.isPressed ? foregroundTappedColor : foregroundDefaultColor)
//            .overlay {
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(configuration.isPressed ? foregroundTappedColor : foregroundDefaultColor, lineWidth: 1)
//            }
//    }
//
//    @ViewBuilder
//    private func disabled(for configuration: Configuration) -> some View {
//        configuration.label
//            .padding(buttonLabelEdgeInsets)
//            .background(disabledBackgroundColor)
//            .cornerRadius(8)
//            .foregroundColor(disabledForegroundColor)
//    }
//}
//
//// MARK: - Bordered Button Style
//public struct SMSBorderedButtonStyle: ButtonStyle {
//    @Environment(\.isEnabled) var isEnabled
//    let foregroundDefaultColor: Color
//    let foregroundTappedColor: Color
//    let backgroundDefaultColor: Color
//    let backgroundTappedColor: Color
//    let disabledForegroundColor: Color
//    let disabledBackgroundColor: Color
//
//    public func makeBody(configuration: Configuration) -> some View {
//        if isEnabled {
//            self.enabled(for: configuration)
//        } else {
//            self.disabled(for: configuration)
//        }
//    }
//
//    @ViewBuilder
//    private func enabled(for configuration: Configuration) -> some View {
//        configuration.label
//            .padding(buttonLabelEdgeInsets)
//            .background(configuration.isPressed ? backgroundTappedColor : backgroundDefaultColor)
//            .cornerRadius(8)
//            .foregroundColor(configuration.isPressed ? foregroundTappedColor : foregroundDefaultColor)
//    }
//
//    @ViewBuilder
//    private func disabled(for configuration: Configuration) -> some View {
//        configuration.label
//            .padding(buttonLabelEdgeInsets)
//            .background(disabledBackgroundColor)
//            .cornerRadius(8)
//            .foregroundColor(disabledForegroundColor)
//    }
//}
//
//// MARK: - Convenience
//extension ButtonStyle where Self == SMSPlainButtonStyle {
//    #if os(iOS)
//    public static func smsPlain(
//        foregroundDefaultColor: Color = .preferredSMSColor(for: .tintColor),
//        foregroundTappedColor: Color = .preferredSMSColor(for: .tintColorTapState),
//        disabledColor: Color = .preferredSMSColor(for: .separator)
//    ) -> Self {
//        .init(
//            foregroundDefaultColor: foregroundDefaultColor,
//            foregroundTappedColor: foregroundTappedColor,
//            disabledColor: disabledColor
//        )
//    }
//    #else
//    public static func smsPlain(
//        foregroundDefaultColor: Color = .preferredSMSColor(for: .tintColor),
//        foregroundTappedColor: Color = .blue,
//        disabledColor: Color = .preferredSMSColor(for: .separator)
//    ) -> Self {
//        .init(
//            foregroundDefaultColor: foregroundDefaultColor,
//            foregroundTappedColor: foregroundTappedColor,
//            disabledColor: disabledColor
//        )
//    }
//    #endif
//}
//
//extension ButtonStyle where Self == SMSOutlinedButtonStyle {
//    #if os(iOS)
//    @available(*, deprecated, message: "Outline style is not supported any longer. Please use a different one")
//    public static func smsOutlined(
//        foregroundDefaultColor: Color = .preferredSMSColor(for: .tintColor),
//        foregroundTappedColor: Color = .preferredSMSColor(for: .tintColorTapState),
//        backgroundDefaultColor: Color = .preferredSMSColor(for: .primaryFill),
//        backgroundTappedColor: Color = .preferredSMSColor(for: .quaternaryFill),
//        disabledForegroundColor: Color = .preferredSMSColor(for: .separator),
//        disabledBackgroundColor: Color = .preferredSMSColor(for: .secondaryFill)
//    ) -> Self {
//        .init(
//            foregroundDefaultColor: foregroundDefaultColor,
//            foregroundTappedColor: foregroundTappedColor,
//            backgroundDefaultColor: backgroundDefaultColor,
//            backgroundTappedColor: backgroundTappedColor,
//            disabledForegroundColor: disabledForegroundColor,
//            disabledBackgroundColor: disabledBackgroundColor
//        )
//    }
//    #else
//    @available(*, deprecated, message: "Outline style is not supported any longer. Please use a different one")
//    public static func smsOutlined(
//        foregroundDefaultColor: Color = .preferredSMSColor(for: .tintColor),
//        foregroundTappedColor: Color = .blue,
//        backgroundDefaultColor: Color = .gray,
//        backgroundTappedColor: Color = .gray,
//        disabledForegroundColor: Color = .preferredSMSColor(for: .separator),
//        disabledBackgroundColor: Color = .gray
//    ) -> Self {
//        .init(
//            foregroundDefaultColor: foregroundDefaultColor,
//            foregroundTappedColor: foregroundTappedColor,
//            backgroundDefaultColor: backgroundDefaultColor,
//            backgroundTappedColor: backgroundTappedColor,
//            disabledForegroundColor: disabledForegroundColor,
//            disabledBackgroundColor: disabledBackgroundColor
//        )
//    }
//    #endif
//}
//
//extension ButtonStyle where Self == SMSBorderedButtonStyle {
//    #if os(iOS)
//    public static func smsBordered(
//        foregroundDefaultColor: Color = .preferredSMSColor(for: .base2),
//        foregroundTappedColor: Color = .preferredSMSColor(for: .base2),
//        backgroundDefaultColor: Color = .preferredSMSColor(for: .tintColor),
//        backgroundTappedColor: Color = .preferredSMSColor(for: .tintColorTapState),
//        disabledForegroundColor: Color = .preferredSMSColor(for: .separator),
//        disabledBackgroundColor: Color = .preferredSMSColor(for: .secondaryFill)
//    ) -> Self {
//        .init(
//            foregroundDefaultColor: foregroundDefaultColor,
//            foregroundTappedColor: foregroundTappedColor,
//            backgroundDefaultColor: backgroundDefaultColor,
//            backgroundTappedColor: backgroundTappedColor,
//            disabledForegroundColor: disabledForegroundColor,
//            disabledBackgroundColor: disabledBackgroundColor
//        )
//    }
//    #else
//    public static func smsBordered(
//        foregroundDefaultColor: Color = .preferredSMSColor(for: .primaryLabel),
//        foregroundTappedColor: Color = .gray,
//        backgroundDefaultColor: Color = .preferredSMSColor(for: .tintColor),
//        backgroundTappedColor: Color = .blue,
//        disabledForegroundColor: Color = .preferredSMSColor(for: .separator),
//        disabledBackgroundColor: Color = .gray
//    ) -> Self {
//        .init(
//            foregroundDefaultColor: foregroundDefaultColor,
//            foregroundTappedColor: foregroundTappedColor,
//            backgroundDefaultColor: backgroundDefaultColor,
//            backgroundTappedColor: backgroundTappedColor,
//            disabledForegroundColor: disabledForegroundColor,
//            disabledBackgroundColor: disabledBackgroundColor
//        )
//    }
//    #endif
//}
//
//// MARK: - Previews
//struct ButtonStyle_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            Button("Button") {}
//                .buttonStyle(.smsPlain())
//                .previewDisplayName("Default - Enabled")
//            Button("Button") {}
//                .buttonStyle(.smsPlain())
//                .disabled(true)
//                .previewDisplayName("Default - Disabled")
//            Button("Button") {}
//                .buttonStyle(.smsOutlined())
//                .previewDisplayName("Outlined - Enabled")
//            Button("Button") {}
//                .buttonStyle(.smsOutlined())
//                .disabled(true)
//                .previewDisplayName("Outlined - Disabled")
//            Button("Button") {}
//                .buttonStyle(.smsBordered())
//                .previewDisplayName("Filled - Enabled")
//            Button("Button") {}
//                .buttonStyle(.smsBordered())
//                .disabled(true)
//                .previewDisplayName("Filled - Disabled")
//        }
//    }
//}
//
//#endif
