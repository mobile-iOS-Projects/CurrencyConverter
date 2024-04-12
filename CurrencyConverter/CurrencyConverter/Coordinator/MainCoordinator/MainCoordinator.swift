//
//  MainCoordinator.swift
//  AppleWatchFacesProject
//
//  Created by Sergey Runovich on 4.09.23.
//

import SwiftUI

@Observable
final class MainCoordinator {
    // MARK: - Published Properties
    var path = NavigationPath()
    
    private var appRootCoordinator: AppRootCoordinator
    
    init(appRootCoordinator: AppRootCoordinator) {
        self.appRootCoordinator = appRootCoordinator
    }
}

// MARK: - Public Methods
extension MainCoordinator {
    func openScreen(screen: MainScreenType) {
        path.append(screen)
    }

    @ViewBuilder
    func getView(screen: MainScreenType?) -> some View {
        if let screen {
            switch screen {
            case .main:
                ChangeCurrencyChildView(coordinator: self)
            }
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    func getSheetView(screen: MainScreenType?) -> some View {
        if let screen {
            switch screen {
            case .main:
                ChangeCurrencyChildView(coordinator: self)
            }
        } else {
            EmptyView()
        }
    }
}
