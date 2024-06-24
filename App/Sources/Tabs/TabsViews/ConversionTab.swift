//
//  ConversionTab.swift
//  App
//
//  Created by Siarhei Runovich on 24.05.24.
//

import Conversion
import SwiftUI
import CurrencyCore
import Conversion

@MainActor
struct ConversionTab: View {
    @State private var routerPath = RouterPath()
    @Binding var selectedTab: Tab

    init(selectedTab: Binding<Tab>) {
        _selectedTab = selectedTab
    }

    var body: some View {
        NavigationStack(path: $routerPath.path) {
            Text("Test")
//            ConversionView(store: .init(initialState: <#T##Reducer.State#>, reducer: <#T##() -> Reducer#>))
                .withAppRouter()
                .withSheetDestinations(sheetDestinations: $routerPath.presentedSheet)
                .toolbar(.hidden, for: .navigationBar)
        }.environment(routerPath)
    }
}
