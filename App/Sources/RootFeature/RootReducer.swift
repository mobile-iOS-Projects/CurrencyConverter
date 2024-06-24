//
//  RootReducer.swift
//  App
//
//  Created by Siarhei Runovich on 14.06.24.
//

import Foundation
import ComposableArchitecture

enum AppStatus: Equatable {
    case launchScreen
    case mainScope
}

@Reducer
struct RootReducer {

    @ObservableState
    struct State {
        var appStatus: AppStatus = .launchScreen
        var launchScreen = LaunchReducer.State()
    }

    enum Action {
        case changeState(AppStatus)
        case launchScreenAction(LaunchReducer.Action)
    }

    var body: some ReducerOf<Self> {
        Scope(state: \.launchScreen, action: \.launchScreenAction) {
            LaunchReducer()
        }
        Reduce { state, action in
            switch action {
            case .changeState(let status):
                state.appStatus = status
                return .none
            case .launchScreenAction(let action):
                if action == .changeState {
                    return .send(.changeState(.mainScope))
                } else {
                    return .none
                }
            }
        }
    }
}
