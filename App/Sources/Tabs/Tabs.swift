//
//  Tabs.swift
//  App
//
//  Created by Siarhei Runovich on 24.05.24.
//

import SwiftUI
import Conversion
import ComposableArchitecture

@MainActor
public enum Tab: Int, Identifiable, Hashable, CaseIterable, Codable, Equatable {
    case conversion, news, settings

    public nonisolated var id: Int {
        rawValue
    }

    @ViewBuilder
    public func makeContentView(selectedTab: Binding<Tab>) -> some View {
        switch self {
        case .conversion:
            ConversionTab(selectedTab: selectedTab)
        case .news:
            NewsTab(selectedTab: selectedTab)
        case .settings:
            SettingsTab(selectedTab: selectedTab)
        }
    }

    @ViewBuilder
    public func makeContentView() -> some View {
        switch self {
        case .conversion:
            ConversionView(store: Store(initialState: ConversionReducer.State()) {
                ConversionReducer()
            })
        case .news:
            Text("News")
        case .settings:
            Text("Settings")
        }
    }

    @ViewBuilder
    public var label: some View {
        Label(title, systemImage: iconName)
    }

    public var title: LocalizedStringKey {
        switch self {
        case .conversion:
            "conversion"
        case .news:
            "news"
        case .settings:
            "settings"
        }
    }

    public var iconName: String {
        switch self {
        case .conversion:
            "rectangle.stack"
        case .news:
            "chart.line.uptrend.xyaxis"
        case .settings:
            "person.2"
        }
    }
}

@MainActor
@Observable
public class SidebarTabs {
    public struct SidedebarTab: Hashable, Codable {
        public let tab: Tab
        var enabled: Bool
    }

    public static let shared = SidebarTabs()

    public var tabs: [SidedebarTab]

    func isEnabled(_ tab: Tab) -> Bool {
        tabs.first(where: { $0.tab.id == tab.id })?.enabled == true
    }

    private init() {
        tabs = [
            .init(tab: .conversion, enabled: true),
            .init(tab: .news, enabled: true),
            .init(tab: .settings, enabled: true),
        ]
    }
}

@MainActor
@Observable
public class iOSTabs {
    public static let shared = iOSTabs()

    public var tabs: [Tab] {
        [.conversion, .news, .settings]
    }

    private init() {}
}
