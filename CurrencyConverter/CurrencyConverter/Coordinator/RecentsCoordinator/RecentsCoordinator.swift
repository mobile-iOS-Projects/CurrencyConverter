//
//  RecentsCoordinator.swift
//  CurrencyConverter
//
//  Created by Sergey Runovich on 11.04.24.
//

import SwiftUI

@Observable
final class RecentsCoordinator {
    // MARK: - Published Properties
    var path = NavigationPath()
    
    private var appRootCoordinator: AppRootCoordinator
    
    init(appRootCoordinator: AppRootCoordinator) {
        self.appRootCoordinator = appRootCoordinator
    }
}

// MARK: - Public Methods
extension RecentsCoordinator {
    func openScreen(screen: RecentsScreenType) {
        path.append(screen)
    }

    @ViewBuilder
    func getView(screen: RecentsScreenType?) -> some View {
        if let screen {
            switch screen {
            case .main:
                RecentsChildView()
            }
        } else {
            EmptyView()
        }
    }
}
