//
//  MainView.swift
//  App
//
//  Created by Siarhei Runovich on 14.06.24.
//

import SwiftUI
import ComposableArchitecture
import Conversion

struct MainTabView: View {

    @Bindable var store: StoreOf<MainTabReducer>
    
    var body: some View {
        TabView(selection: $store.selectedTab) {
            ConversionView(store: store.scope(state: \.conversionView, action: \.conversionView))
            .tabItem {
                Tab.conversion.label
            }
            .tag(Tab.conversion)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbar(.hidden, for: .navigationBar)

            Text("News")
                .tabItem {
                    Tab.news.label
                }
                .tag(Tab.news)
                .toolbarBackground(.visible, for: .tabBar)

            Text("Settings")
                .tabItem {
                    Tab.settings.label
                }
                .tag(Tab.settings)
                .toolbarBackground(.visible, for: .tabBar)
        }
    }
}
