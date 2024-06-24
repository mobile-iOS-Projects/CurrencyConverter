//
//  StatisticView.swift
//  Conversion
//
//  Created by Siarhei Runovich on 20.06.24.
//

import SwiftUI
import ComposableArchitecture

public struct StatisticView: View {

    @Bindable var store: StoreOf<StatisticReducer>

    public init(store: StoreOf<StatisticReducer>) {
        self.store = store
    }
    
    public var body: some View {
        Text("StatisticView")
            .onTapGesture {
                store.send(.testction)
            }
    }
}

#Preview {
    StatisticView(store: Store(initialState: StatisticReducer.State()) {
        StatisticReducer()
    })
}
