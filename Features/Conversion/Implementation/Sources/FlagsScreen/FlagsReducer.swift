//
//  FlagsReducer.swift
//  Conversion
//
//  Created by Siarhei Runovich on 25.06.24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
public struct FlagsReducer {

    public init() {
    }

    @ObservableState
    public struct State {
        var flagsItems: [FlagItem] = flagsImages
        var coordinator: UICoordinator = .init()
    }

    public enum Action {
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
        }
    }
}
