//
//  Decodable+Extensions.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

extension Decodable {
    /// A helper to instanciate a value based on a data
    public static func object(from data: Data) -> Self? {
        try? JSONDecoder().decode(Self.self, from: data)
    }
}
