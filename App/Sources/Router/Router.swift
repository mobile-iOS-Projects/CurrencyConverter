import Combine
import Foundation
import Observation
import SwiftUI

public enum RouterDestination: Hashable {
    case conversionList
    case newsList
    case settingsList
}

public enum SheetDestination: Identifiable, Hashable {
    public static func == (lhs: SheetDestination, rhs: SheetDestination) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    case conversionList
    case newsList
    case settingsList

    public var id: String {
        switch self {
        case .conversionList:
            "conversionList"
        case .newsList:
            "newsList"
        case .settingsList:
            "settingsList"
        }
    }
}

public enum WindowDestinationEditor: Hashable, Codable {
    case conversionList
    case newsList
    case settingsList
}

public enum WindowDestinationMedia: Hashable, Codable {
  case testViewer
}

@MainActor
@Observable public class RouterPath {
    public var path: [RouterDestination] = []
    public var presentedSheet: SheetDestination?

    public init() {}

    public func navigate(to: RouterDestination) {
        path.append(to)
    }
}
