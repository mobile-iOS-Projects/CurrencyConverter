
import SwiftUI
import ConversionAPI
import CurrencyCore
import Conversion

@MainActor
extension View {
    public func withAppRouter() -> some View {
        navigationDestination(for: RouterDestination.self) { destination in
            switch destination {
            case .newsList:
                Text("newsList")
            case .settingsList:
                Text("settingsList")
            default: EmptyView()
            }
        }
    }

    public func withSheetDestinations(sheetDestinations: Binding<SheetDestination?>) -> some View {
        sheet(item: sheetDestinations) { destination in
            switch destination {
            case .conversionDetailsView:
                Text("newsList")
//                ConversionDetailsScreen()
            case .newsList:
                Text("newsList")
            case .settingsList:
                Text("settingsList")
            }
        }
    }
}
