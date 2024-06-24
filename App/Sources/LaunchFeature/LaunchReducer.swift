//
//  LaunchReducer.swift
//  App
//
//  Created by Siarhei Runovich on 14.06.24.
//

import ComposableArchitecture
import Foundation

@Reducer
struct LaunchReducer {

    @ObservableState
    struct State: Equatable {}

    enum Action {
        case changeState
    }

    var body: some ReducerOf<Self> {

        Reduce { state, action in
            switch action {
            case .changeState:
                return .none
            }
        }
    }
}
