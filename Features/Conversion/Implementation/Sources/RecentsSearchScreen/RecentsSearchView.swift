//
//  RecentsSearchView.swift
//  Conversion
//
//  Created by Siarhei Runovich on 20.06.24.
//

import SwiftUI
import ComposableArchitecture

public struct RecentsSearchView: View {

    @Bindable var store: StoreOf<RecentsSearchReducer>

    public init(store: StoreOf<RecentsSearchReducer>) {
        self.store = store
    }
    
    public var body: some View {
        Text("RecentsSearchView")
            .onTapGesture {
                store.send(.testction)
            }
    }
}

#Preview {
    RecentsSearchView(store: Store(initialState: RecentsSearchReducer.State()) {
        RecentsSearchReducer()
    })
}
