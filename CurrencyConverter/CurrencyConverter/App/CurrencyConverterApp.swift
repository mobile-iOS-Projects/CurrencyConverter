//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//
//  Created by Sergey Runovich on 7.04.24.
//

import SwiftUI

@main
struct CurrencyConverterApp: App {
    @State private var appRootCoordinator = AppRootCoordinator()

    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootCoordinator.currentRoot {
                case .main:
                    TabView() {
                        ChangeCurrencyView(coordinator: MainCoordinator(appRootCoordinator: appRootCoordinator))
                            .tabItem {
                                Label("Currency", systemImage: "coloncurrencysign.circle.fill")
                            }
                        RecentsView(coordinator: RecentsCoordinator(appRootCoordinator: appRootCoordinator))
                            .tabItem {
                                Label("Recents", systemImage: "swiftdata")
                            }
                        SettingsView(coordinator: SettingsCoordinator(appRootCoordinator: appRootCoordinator))
                            .tabItem {
                                Label("Settings", systemImage: "gear")
                            }
                    }.accentColor(Color.pink)
                case .authentication:
                    AuthenticationView(coordinator: AuthorizationCoordinator(appRootCoordinator: appRootCoordinator))
                }
            }
            .environment(appRootCoordinator)
            .animation(.easeInOut(duration: 0.3), value: appRootCoordinator.currentRoot)
        }
    }
}
