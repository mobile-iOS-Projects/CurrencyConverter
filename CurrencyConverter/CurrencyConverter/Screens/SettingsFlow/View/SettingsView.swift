//
//  SettingsView.swift
//  CurrencyConverter
//
//  Created by Sergey Runovich on 11.04.24.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Coordinator
    @Bindable var coordinator: SettingsCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                ZStack{
                    Rectangle().fill(Color.red)
                    Text("Tap on me")
                        .onTapGesture {
                            coordinator.openScreen(screen: .main)
                        }
                }
            }.navigationDestination(for: SettingsScreenType.self) { page in
                coordinator.getView(screen: page)
            }
        }
    }
}

#Preview {
    SettingsView(coordinator: .init(appRootCoordinator: .init()))
}
