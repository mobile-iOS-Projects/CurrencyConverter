//
//  SMSShadowLevel.swift
//  CoreUI
//
//  Created by Weiss, Alexander on 30.04.22.
//

import Foundation

public enum SMSShadowLevel: CaseIterable {
    /// No shadow applied
    case none

    /// Base layers, flat headers / footers
    case base

    /// Grouped layers, floating header / bar
    case level0

    /// Cards, grouped layers, floating header / bar (scrolled) / footers
    case level1

    /// Cards
    case level2

    /// Emphasized cards, overlay panels
    case level3

    /// Emphasized overlay panels
    case level4
}

// MARK: - CustomDebugStringConvertible
extension SMSShadowLevel: CustomDebugStringConvertible {
    public var debugDescription: String {
        switch self {
        case .none:
            return "none"
        case .base:
            return "base"
        case .level0:
            return "level0"
        case .level1:
            return "level1"
        case .level2:
            return "level2"
        case .level3:
            return "level3"
        case .level4:
            return "level4"
        }
    }
}
