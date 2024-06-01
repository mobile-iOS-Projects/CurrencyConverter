//
//  UserDefaults+Extensions.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

extension UserDefaults {
    /// Sets the property of the receiver specified by a given key to a given value.
    ///
    /// This method is specifically designed for `Codable` conforming objects
    ///
    /// - Parameters:
    ///   - value: The value for the property identified by key.
    ///   - key: The name of one of the receiver's properties.
    public func set(value: some Codable, forKey key: String) {
        let data = try? JSONEncoder().encode(value)
        setValue(data, forKey: key)
    }

    /// Returns the Codable object associated with the specified key.
    ///
    /// This method is specifically designed for `Codable` conforming objects
    ///
    /// - Parameters:
    ///   - key: A key in the current user‘s defaults database.
    /// - Returns: The data object associated with the specified key, or nil if the key does not exist or its value is not a
    /// Codable object.
    public func value<Element: Codable>(forKey key: String) -> Element? {
        guard let data = data(forKey: key) else { return nil }
        let element = try? JSONDecoder().decode(Element.self, from: data)
        return element
    }
}

extension UserDefaults {
    // swiftlint:disable:next force_unwrapping
    public static var group = UserDefaults(suiteName: SharedAppGroup.sharedUserDefaults.id)!
}
