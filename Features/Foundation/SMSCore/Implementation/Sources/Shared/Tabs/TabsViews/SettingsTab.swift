//
//  SettingsTab.swift
//  SMSCore
//
//  Created by Siarhei Runovich on 26.05.24.
//

import SwiftUI

@MainActor
struct SettingsTab: View {
    @State private var routerPath = RouterPath()
    @Binding var selectedTab: Tab

    init(selectedTab: Binding<Tab>) {
        _selectedTab = selectedTab
    }

    var body: some View {
        NavigationStack(path: $routerPath.path) {
           TestTab()
                .withAppRouter()
                .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
        }.environment(routerPath)
    }
}

@MainActor
struct TestTab: View {
    @Environment(RouterPath.self) private var routerPath

    var body: some View {
        Rectangle()
            .foregroundStyle(Color.cyan)
            .onTapGesture {
                routerPath.presentedSheet = .conversionList
            }
    }
}

@MainActor
struct ChildViewTab: View {
    var body: some View {
        Text("yes")
    }
}
