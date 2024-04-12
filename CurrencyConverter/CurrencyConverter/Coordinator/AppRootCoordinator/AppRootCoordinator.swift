//
//  RootCoordinator.swift
//  MoviesTVOS
//
//  Created by Sergey Runovich on 21.11.23.
//

import SwiftUI
import Observation

@Observable
final class AppRootCoordinator {
    // MARK: - Current Root
    var currentRoot: AppRoots = .authentication

}
