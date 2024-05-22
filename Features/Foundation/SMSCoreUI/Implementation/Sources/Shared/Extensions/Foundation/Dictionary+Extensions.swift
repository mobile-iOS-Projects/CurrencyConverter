//
//  Dictionary+Extensions.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

// MARK: - Codable

/// A wrapper around `Dictionary` which allows for easy encoding to and decoding from JSON
@propertyWrapper
public struct DictionaryWrapper<Key: Hashable & RawRepresentable, Value: Codable>: Codable
    where Key.RawValue: Codable & Hashable
{
    public var wrappedValue: [Key: Value]

    public init() {
        wrappedValue = [:]
    }

    public init(wrappedValue: [Key: Value]) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawKeyedDictionary = try container.decode([Key.RawValue: Value].self)

        wrappedValue = [:]

        for (rawKey, value) in rawKeyedDictionary {
            guard let key = Key(rawValue: rawKey) else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Invalid key: cannot initialize '\(Key.self)' from invalid '\(Key.RawValue.self)' value '\(rawKey)'"
                )
            }
            wrappedValue[key] = value
        }
    }

    public func encode(to encoder: Encoder) throws {
        let rawKeyedDictionary = Dictionary(uniqueKeysWithValues: wrappedValue.map { ($0.rawValue, $1) })
        var container = encoder.singleValueContainer()
        try container.encode(rawKeyedDictionary)
    }
}
