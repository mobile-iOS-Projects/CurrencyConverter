//
//  MainTabReducer.swift
//  App
//
//  Created by Siarhei Runovich on 14.06.24.
//

import ComposableArchitecture
import Foundation
import Conversion

@Reducer struct MainTabReducer {
    @ObservableState
    struct State {
        var selectedTab: Tab = .conversion
        var iOSTabs: [Tab] = [.conversion, .news, .settings]
        var conversionView = ConversionReducer.State()
    }

    enum Action: BindableAction {
        case tabSelected(Tab)
        case binding(BindingAction<State>)
        case conversionView(ConversionReducer.Action)
    }

    var body: some ReducerOf<Self> {
        BindingReducer()

        Scope(state: \.conversionView, action: \.conversionView) {
            ConversionReducer()
        }
        Reduce { state, action in
            switch action {
            case let .tabSelected(tab):
                state.selectedTab = tab
                return .none
            case .binding:
                return .none
            case .conversionView:
                return .none
            }
        }
    }
}
