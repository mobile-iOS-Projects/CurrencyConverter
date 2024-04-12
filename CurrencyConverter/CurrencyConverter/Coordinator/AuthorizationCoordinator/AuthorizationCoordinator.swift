//
//  AuthorizationCoordinator.swift
//  MoviesTVOS
//
//  Created by Sergey Runovich on 1.11.23.
//

import SwiftUI

@Observable
final class AuthorizationCoordinator {
    // MARK: - Published Properties
    var path = NavigationPath()
    
    private var appRootCoordinator: AppRootCoordinator
    
    init(appRootCoordinator: AppRootCoordinator) {
        self.appRootCoordinator = appRootCoordinator
    }
    
    func goToMain() {
        appRootCoordinator.currentRoot = .main
    }
}

// MARK: - Public Methods
extension AuthorizationCoordinator {
    func openScreen(screen: AuthorizationScreenType) {
        path.append(screen)
    }
 
    @ViewBuilder
    func getView(screen: AuthorizationScreenType?) -> some View {
        if let screen {
            switch screen {
            case .main:
                EmptyView()
            }
        } else {
            EmptyView()
        }
    }
}
