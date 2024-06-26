//
//  FlagsView.swift
//  Conversion
//
//  Created by Siarhei Runovich on 25.06.24.
//

import SwiftUI
import ComposableArchitecture

struct FlagsView: View {
    
    @Bindable var store: StoreOf<FlagsReducer>

    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 15) {
                Text("Countries Flags")
                    .font(.largeTitle.bold())
                    .padding(.vertical, 10)

                /// Grid Image View
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 2), spacing: 10) {
                    ForEach(store.flagsItems) { item in
                        flagCardView(item)
                    }
                }
            }
            .padding(15)
            .background(ScrollViewExtractor {
                store.coordinator.scrollView = $0
            })
        }
        .opacity(store.coordinator.hideRootView ? 0 : 1)
        .scrollDisabled(store.coordinator.hideRootView)
        .allowsTightening(!store.coordinator.hideRootView)
        .overlay {
            FlagDetailView()
                .environment(store.coordinator)
                .allowsTightening(store.coordinator.hideLayer)
        }
    }
}

extension FlagsView {
    /// Flag Card View
    @ViewBuilder
    private func flagCardView(_ flagItem: FlagItem) -> some View {
        GeometryReader {
            let frame = $0.frame(in: .global)

            ImageView(flagItem: flagItem)
                .clipShape(.rect(cornerRadius: 10))
                .contentShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    store.coordinator.toogleView(show: true, frame: frame, item: flagItem)
                }
        }.frame(height: 220)
    }
}

#Preview {
    FlagsView(store: .init(initialState: FlagsReducer.State(), reducer: {
        FlagsReducer()
    }))
}
