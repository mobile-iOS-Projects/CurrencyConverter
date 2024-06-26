//
//  RootView.swift
//  App
//
//  Created by Siarhei Runovich on 14.06.24.
//

import SwiftUI
import ComposableArchitecture
#if !os(visionOS)
import SwiftUIIntrospect
#endif

struct DataModel: Identifiable, Hashable {
    let id = UUID()
    let text: String
}

class SampleData {
    static let firstScreenData = [
        DataModel(text: "🚂 Trains"),
        DataModel(text: "✈️ Planes"),
        DataModel(text: "🚗 Automobiles"),
    ]

    static let secondScreenData = [
        DataModel(text: "Slow"),
        DataModel(text: "Regular"),
        DataModel(text: "Fast"),
    ]

    static let lastScreenData = [
        DataModel(text: "Wrong"),
        DataModel(text: "So-so"),
        DataModel(text: "Right"),
    ]
}

struct RootView: View {

    @Bindable var store: StoreOf<RootReducer>
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let testStore = Store(initialState: MainTabReducer.State()) {
        MainTabReducer()
    }

    var body: some View {
        Group {
            switch store.appStatus {
            case .launchScreen:
                let launch = store.scope(state: \.launchScreen, action: \.launchScreenAction)
                LaunchView(store: launch)
                    .transition(.opacity) // Transition effect
            case .mainScope:
#if os(visionOS)
                MainTabView(store: Store(initialState: MainTabReducer.State()) {
                    MainTabReducer()
                })
                .transition(.opacity) // Transition effect
#else
                if horizontalSizeClass == .compact {
                    MainTabView(store: testStore)
                    .transition(.opacity)
                } else {
                    if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
                        NavigationSplitView(preferredCompactColumn: .constant(.detail)) {
                            List(SampleData.firstScreenData) { item in
                                NavigationLink(item.text, value: item)
                            }
                            .navigationTitle("Sidebar")
                            .navigationSplitViewColumnWidth(200)
                        } detail: {
                            VStack(alignment: .leading) {
                                Text("Previously Selected Item")
                                
                                Text("Previously Item")
                                    .padding()
                                
                            }
                            .navigationTitle("Detail")
                        }
                        .navigationSplitViewStyle(.balanced)
                } else {
                    MainTabView(store: testStore)
                    .transition(.opacity)
                }
                }
#endif
            }
        }
        .animation(.easeInOut(duration: 0.5), value: store.appStatus) // Animation
    }
}
