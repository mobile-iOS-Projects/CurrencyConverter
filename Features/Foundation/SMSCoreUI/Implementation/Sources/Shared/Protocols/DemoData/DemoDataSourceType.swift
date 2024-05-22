//
//  DemoDataSourceType.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

// MARK: - DemoDataDecoder
protocol DemoDataDecoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

// MARK: - DemoDataSourceType
public struct DemoDataSourceType {
    /// Filename of the file to load data from
    let fileName: String

    /// File extension of the file to load data from
    let fileExtension: String

    /// Decoder to use to decode data from the file
    let decoder: DemoDataDecoder
}

// MARK: - DemoDataSourceType + Predefined
extension DemoDataSourceType {
    public static func json(fileName: String) -> DemoDataSourceType {
        let decoder = JSONDecoder().with {
            $0.dateDecodingStrategy = .iso8601
        }
        return DemoDataSourceType(fileName: fileName, fileExtension: "json", decoder: decoder)
    }

    public static func plist(fileName: String) -> DemoDataSourceType {
        DemoDataSourceType(fileName: fileName, fileExtension: "plist", decoder: PropertyListDecoder())
    }
}

// MARK: - PropertyListDecoder + JSONDecoder
extension JSONDecoder: DemoDataDecoder {}

// MARK: - PropertyListDecoder + DemoDataDecoder
extension PropertyListDecoder: DemoDataDecoder {}
