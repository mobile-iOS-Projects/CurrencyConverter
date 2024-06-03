
import SwiftUI

@MainActor
extension View {
    public func withAppRouter() -> some View {
        navigationDestination(for: RouterDestination.self) { destination in
            switch destination {
            case .conversionList:
                Text("conversionList")
            case .newsList:
                Text("newsList")
            case .settingsList:
                Text("settingsList")
            }
        }
    }

    public func withSheetDestinations(sheetDestinations: Binding<SheetDestination?>) -> some View {
        sheet(item: sheetDestinations) { destination in
            switch destination {
            case .conversionList:
                Text("conversionList")
            case .newsList:
                Text("newsList")
            case .settingsList:
                Text("settingsList")
            }
        }
    }
}
