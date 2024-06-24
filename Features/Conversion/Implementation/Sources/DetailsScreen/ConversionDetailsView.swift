//
//  ConversionDetailsView.swift
//  ConversionAPI
//
//  Created by Siarhei Runovich on 11.06.24.
//

import SwiftUI
import ComposableArchitecture

public struct ConversionDetailsView: View {

    @Bindable var store: StoreOf<ConversionDetailsReducer>
    
    public init(store: StoreOf<ConversionDetailsReducer>) {
        self.store = store
    }
    
    public var body: some View {
        Text("ConversionDetailsView!")
    }
}

#Preview {
    ConversionDetailsView(store: Store(initialState: ConversionDetailsReducer.State()) {
        ConversionDetailsReducer()
    })
}
