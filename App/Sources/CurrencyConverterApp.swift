import Factory
import Networking
import SwiftUI

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
