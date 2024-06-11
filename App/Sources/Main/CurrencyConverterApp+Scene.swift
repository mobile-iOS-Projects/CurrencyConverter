//
//  CurrencyConverterApp+Scene.swift
//  App
//
//  Created by Siarhei Runovich on 24.05.24.
//

import AppIntents
import SwiftData
import SwiftUI
import Conversion

extension CurrencyConverterApp {
    var appScene: some Scene {
        WindowGroup(id: "MainWindow") {
            AppView(selectedTab: $selectedTab, appRouterPath: $appRouterPath)
                .onAppear {
                    print("onAppear")
                }
                .modelContainer(for: ConversionsCountries.self)
        }
        #if targetEnvironment(macCatalyst)
        .defaultSize(width: 1100, height: 1400)
        #elseif os(visionOS)
        .defaultSize(width: 800, height: 1200)

        #endif

        .onChange(of: scenePhase) { _, newValue in
            handleScenePhase(scenePhase: newValue)
        }
    }

    @SceneBuilder
    var otherScenes: some Scene {
        WindowGroup(for: WindowDestinationEditor.self) { destination in
            Group {
                switch destination.wrappedValue {
                case .conversionList:
                    Text("conversionList Scene")
                case .newsList:
                    Text("newsList Scene")
                case .settingsList:
                    Text("settingsList Scene")
                case .none:
                    EmptyView()
                }
            }
            .environment(RouterPath())
            .frame(minWidth: 300, minHeight: 400)
        }
        .defaultSize(width: 600, height: 800)
        .windowResizability(.contentMinSize)

        WindowGroup(for: WindowDestinationMedia.self) { destination in
            Group {
                switch destination.wrappedValue {
                case .testViewer:
                    Text("testViewer Scene")
                case .none:
                    EmptyView()
                }
            }
            .frame(minWidth: 300, minHeight: 400)
        }
        .defaultSize(width: 1200, height: 1000)
        .windowResizability(.contentMinSize)
    }
}
