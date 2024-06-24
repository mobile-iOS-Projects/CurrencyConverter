//
//  StatisticReducer.swift
//  Conversion
//
//  Created by Siarhei Runovich on 20.06.24.
//


import SwiftUI
import ComposableArchitecture

@Reducer
public struct StatisticReducer {


    public init() {
    }

    @ObservableState
    public struct State {
        
        public init() {
            
        }
    }

    public enum Action {
        case testction
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .testction:
                return .none
            }
        }
    }
}
