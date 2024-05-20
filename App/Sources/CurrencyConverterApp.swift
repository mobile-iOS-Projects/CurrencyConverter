import SwiftUI
import Factory
import Networking

@main
struct CurrencyConverterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension Container {
    var networkingAPI: Factory<NetworkingAPI> {
        self { Networking() }
    }
}
