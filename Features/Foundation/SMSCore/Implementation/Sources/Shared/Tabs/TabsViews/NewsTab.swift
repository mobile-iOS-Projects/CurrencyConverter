//
//  NewsTab.swift
//  SMSCore
//
//  Created by Siarhei Runovich on 26.05.24.
//

import SwiftUI

@MainActor
struct NewsTab: View {
    @State private var routerPath = RouterPath()
    @Binding var selectedTab: Tab

    init(selectedTab: Binding<Tab>) {
        _selectedTab = selectedTab
    }

    var body: some View {
        NavigationStack(path: $routerPath.path) {
            Rectangle()
                .foregroundStyle(Color.green)
                .withAppRouter()
                .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
        }.environment(routerPath)
    }
}
