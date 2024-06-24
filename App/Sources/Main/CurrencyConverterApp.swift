//
//  CurrencyConverterApp.swift
//  App
//
//  Created by Siarhei Runovich on 24.05.24.
//

import AVFAudio
import SwiftUI
import SwiftData
import CurrencyCore
import Env
import ComposableArchitecture

@main
 struct CurrencyConverterApp: App {
//    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

//    @Environment(\.scenePhase) var scenePhase
//    @Environment(\.openWindow) var openWindow

//    @State var selectedTab: Tab = .conversion
//    @State var appRouterPath = RouterPath()
//    @State var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            RootView(store: Store(initialState: RootReducer.State()) {
                RootReducer()
            })
            //        appScene
            //        otherScenes
        }
    }
}
//
//extension CurrencyConverterApp {
//    func handleScenePhase(scenePhase: ScenePhase) {
//        switch scenePhase {
//        case .background:
//            print("background")
//        case .active:
//            print("active")
//        default:
//            break
//        }
//    }
//}
