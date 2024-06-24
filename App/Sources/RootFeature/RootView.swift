//
//  RootView.swift
//  App
//
//  Created by Siarhei Runovich on 14.06.24.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {

    @Bindable var store: StoreOf<RootReducer>

    var body: some View {
        Group {
            switch store.appStatus {
            case .launchScreen:
                let launch = store.scope(state: \.launchScreen, action: \.launchScreenAction)
                LaunchView(store: launch)
                    .transition(.opacity) // Transition effect
            case .mainScope:
                MainTabView(store: Store(initialState: MainTabReducer.State()) {
                    MainTabReducer()
                })
                .transition(.opacity) // Transition effect
            }
        }
        .animation(.easeInOut(duration: 0.5), value: store.appStatus) // Animation
    }
}
