//
//  LaunchView.swift
//  App
//
//  Created by Siarhei Runovich on 14.06.24.
//

import SwiftUI
import Lottie
import ComposableArchitecture

struct LaunchView: View {

    @Bindable var store: StoreOf<LaunchReducer>

    var body: some View {
        VStack {
            LottieView {
                LottieAnimation.named("lottieAnimation")
            }
            .playing(loopMode: .playOnce)
            .animationDidFinish({ completed in
                store.send(.changeState)
            })
            .frame(width: 500, height: 500)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray.opacity(0.25))
    }
}
