//
//  SettingsCoordinator.swift
//  CurrencyConverter
//
//  Created by Sergey Runovich on 11.04.24.
//

import SwiftUI

@Observable
final class SettingsCoordinator {
    // MARK: - Published Properties
    var path = NavigationPath()
    
    private var appRootCoordinator: AppRootCoordinator
    
    init(appRootCoordinator: AppRootCoordinator) {
        self.appRootCoordinator = appRootCoordinator
    }
}

// MARK: - Public Methods
extension SettingsCoordinator {
    func openScreen(screen: SettingsScreenType) {
        path.append(screen)
    }

    @ViewBuilder
    func getView(screen: SettingsScreenType?) -> some View {
        if let screen {
            switch screen {
            case .main:
                SettingsChildView()
            }
        } else {
            EmptyView()
        }
    }
}
