////
////  SwiftUI+Shadows.swift
////  CoreUI
////
////  Created by Weiss, Alexander on 30.04.22.
////
//
//#if os(iOS)
//
//import SwiftUI
//
//extension View {
//    /// Apply Fiori style levels to the view
//    ///
//    /// - Parameters:
//    ///   - level: The shadow level
//    @ViewBuilder func smsShadow(level: SMSShadowLevel = .base) -> some View {
//        switch level {
//        case .none:
//            self
//        case .base:
//            self.baseLevelShadow()
//        case .level0:
//            self.levelZeroShadow()
//        case .level1:
//            self.levelOneShadow()
//        case .level2:
//            self.levelTwoShadow()
//        case .level3:
//            self.levelThreeShadow()
//        case .level4:
//            self.levelFourShadow()
//        }
//    }
//
//    // MARK: - Level Base
//    private func baseLevelShadow() -> some View {
//        self
//    }
//
//    // MARK: - Level 0
//    private func levelZeroShadow() -> some View {
//        self.shadow(
//            color: .preferredSMSColor(for: .sectionShadow),
//            radius: 2,
//            shadowOffset: .zero
//        )
//    }
//
//    // MARK: - Level 1
//    private func levelOneShadow() -> some View {
//        self
//            // Layer 1
//            .shadow(
//                color: .preferredSMSColor(for: .cardShadow),
//                radius: 4,
//                shadowOffset: .init(horizontalOffset: 0, verticalOffset: 1)
//            )
//            // Layer 2
//            .shadow(
//                color: .preferredSMSColor(for: .sectionShadow),
//                radius: 2,
//                shadowOffset: .zero
//            )
//    }
//
//    // MARK: - Level 2
//    private func levelTwoShadow() -> some View {
//        self
//            // Layer 1
//            .shadow(
//                color: .preferredSMSColor(for: .cardShadow),
//                radius: 8,
//                shadowOffset: .init(horizontalOffset: 0, verticalOffset: 2)
//            )
//            // Layer 2
//            .shadow(
//                color: .preferredSMSColor(for: .sectionShadow),
//                radius: 2,
//                shadowOffset: .zero
//            )
//    }
//
//    // MARK: - Level 3
//    private func levelThreeShadow() -> some View {
//        self
//            // Layer 1
//            .shadow(
//                color: .preferredSMSColor(for: .cardShadow),
//                radius: 32,
//                shadowOffset: .init(horizontalOffset: 0, verticalOffset: 16)
//            )
//            // Layer 2
//            .shadow(
//                color: .preferredSMSColor(for: .sectionShadow),
//                radius: 16,
//                shadowOffset: .init(horizontalOffset: 0, verticalOffset: 8)
//            )
//            // Layer 3
//            .shadow(
//                color: .preferredSMSColor(for: .sectionShadow),
//                radius: 2,
//                shadowOffset: .zero
//            )
//    }
//
//    // MARK: - Level 4
//    private func levelFourShadow() -> some View {
//        self
//            // Layer 1
//            .shadow(
//                color: .preferredSMSColor(for: .cardShadow),
//                radius: 64,
//                shadowOffset: .init(horizontalOffset: 0, verticalOffset: 32)
//            )
//            // Layer 2
//            .shadow(
//                color: .preferredSMSColor(for: .cardShadow),
//                radius: 32,
//                shadowOffset: .init(horizontalOffset: 0, verticalOffset: 16)
//            )
//            // Layer 3
//            .shadow(
//                color: .preferredSMSColor(for: .sectionShadow),
//                radius: 16,
//                shadowOffset: .init(horizontalOffset: 0, verticalOffset: 8)
//            )
//            // Layer 4
//            .shadow(
//                color: .preferredSMSColor(for: .separatorOpaque),
//                radius: 2,
//                shadowOffset: .zero
//            )
//    }
//}
//
//// MARK: - Convenience Helpers
//extension View {
//    fileprivate func shadow(color: Color, opacity: Double = 1, radius: CGFloat, shadowOffset: ShadowOffset = .zero) -> some View {
//        self.shadow(
//            color: color.opacity(opacity),
//            radius: radius,
//            x: shadowOffset.width,
//            y: shadowOffset.height
//        )
//    }
//}
//
//// MARK: - LibraryContentProvider
//struct LibraryModifierContent: LibraryContentProvider {
//    func modifiers(base: Text) -> [LibraryItem] {
//        LibraryItem(
//            base.smsShadow(level: .level1),
//            visible: true,
//            title: "SAPStart Shadow",
//            category: .effect
//        )
//    }
//}
//
//// MARK: - PreviewProvider
//struct SAPStartShadowModifier_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ForEach(SMSShadowLevel.allCases, id: \.self) { level in
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(Color.white)
//                    .frame(width: 100, height: 100)
//                    .smsShadow(level: level)
//                    .frame(width: 150, height: 150)
//                    .previewDisplayName("Shadow Level \(level)")
//            }
//        }
//    }
//}
//
//#endif
