//
//  Bundle+Current.swift
//  Personalization
//
//  Created by Schmitt, Frank on 25.08.22.
//

import Foundation

extension Bundle {
    /// Returns current target's Bundle (for internal usage only)
    static var current: Bundle { .init(for: BundleAssociatedType.self) }
}

/// A type to be associated with current target's Bundle
private final class BundleAssociatedType {}
