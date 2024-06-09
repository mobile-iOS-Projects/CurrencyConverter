//
//  ConversionTab.swift
//  App
//
//  Created by Siarhei Runovich on 24.05.24.
//

import Conversion
import SwiftUI

@MainActor
struct ConversionTab: View {
    @State private var routerPath = RouterPath()
    @Binding var selectedTab: Tab

    init(selectedTab: Binding<Tab>) {
        _selectedTab = selectedTab
    }

    var body: some View {
        NavigationStack(path: $routerPath.path) {
            ConversionScreen()
                .withAppRouter()
                .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
        }.environment(routerPath)
    }
}
