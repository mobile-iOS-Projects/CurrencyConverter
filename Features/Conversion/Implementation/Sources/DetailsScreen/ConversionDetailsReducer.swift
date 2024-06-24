//
//  ConversionDetailsReducer.swift
//  Conversion
//
//  Created by Siarhei Runovich on 20.06.24.
//

import SwiftUI
import ComposableArchitecture

@Reducer
public struct ConversionDetailsReducer {


    public init() {
    }

    @ObservableState
    public struct State: Equatable {
        
        public init() {
            
        }
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
