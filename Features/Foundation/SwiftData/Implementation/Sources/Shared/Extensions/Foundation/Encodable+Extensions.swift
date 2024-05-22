//
//  Encodable+Extensions.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

extension Encodable {
    /// JSON representation of the value
    ///
    /// - Returns: A `Dictionary` instance as a representation of the value
    public var jsonObject: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self),
              let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else { return nil }

        return jsonObject
    }

    /// Returns the encoded data representation of the value.
    ///
    /// - Returns: A `Data` instance representing the encoded value.
    public var data: Data? {
        try? JSONEncoder().encode(self)
    }
}
