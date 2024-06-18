//
//  SettingsTab.swift
//  SMSCore
//
//  Created by Siarhei Runovich on 26.05.24.
//

import Settings
import SwiftUI
import CurrencyCore

@MainActor
struct SettingsTab: View {
    @State private var routerPath = RouterPath()
    @Binding var selectedTab: Tab

    init(selectedTab: Binding<Tab>) {
        _selectedTab = selectedTab
    }

    var body: some View {
        NavigationStack(path: $routerPath.path) {
            SettingsScreen()
                .withAppRouter()
                .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
        }.environment(routerPath)
    }
}
