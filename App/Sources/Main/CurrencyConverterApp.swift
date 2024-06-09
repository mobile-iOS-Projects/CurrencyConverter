//
//  CurrencyConverterApp.swift
//  App
//
//  Created by Siarhei Runovich on 24.05.24.
//

import AVFAudio
import SwiftUI

@main
struct CurrencyConverterApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    @Environment(\.scenePhase) var scenePhase
    @Environment(\.openWindow) var openWindow

    @State var selectedTab: Tab = .conversion
    @State var appRouterPath = RouterPath()

    var body: some Scene {
        appScene
        otherScenes
    }
}

extension CurrencyConverterApp {
    func handleScenePhase(scenePhase: ScenePhase) {
        switch scenePhase {
        case .background:
            print("background")
        case .active:
            print("active")
        default:
            break
        }
    }
}
