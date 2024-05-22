//
//  DemoDataProviding.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

/// This protocol provides methods for loading Codable objects from file (assets)
///
/// Depending on the contents of the file you can choose between the  two functions - one provides an array of objects (if your
/// file contains an array of objects) or a single object (if your file contains only a single object).
public protocol DemoDataProviding {
    /// Decode an array of objects from the given file
    ///
    /// - Parameters:
    ///   - bundle: The bundle in which the file is present
    ///   - type: `Codable` type to decode
    ///   - source: Source from which to load the object
    /// - Returns: Array of objects
    static func demoObjects<T>(bundle: Bundle, for type: T.Type, from source: DemoDataSourceType) -> [T] where T: Decodable

    /// Decode a single object from the given file
    ///
    /// - Parameters:
    ///   - bundle: The bundle in which the file is present
    ///   - type: `Codable` type to decode
    ///   - source: Source from which to load the object
    /// - Returns: A single object
    static func demoObject<T>(bundle: Bundle, for type: T.Type, from fileName: DemoDataSourceType) -> T where T: Decodable
}

extension DemoDataProviding {
    public static func demoObjects<T: Decodable>(bundle: Bundle, for _: T.Type, from source: DemoDataSourceType) -> [T] {
        do {
            return try source.decoder.decode(
                [T].self,
                from: loadFile(bundle: bundle, named: source.fileName, withExtension: source.fileExtension)
            )
        } catch {
            preconditionFailure(
                "Decoding error: expected an array of `\(T.Type.self)` objects in the loaded asset. The decoding error is: \(error)"
            )
        }
    }

    public static func demoObject<T: Decodable>(bundle: Bundle, for _: T.Type, from source: DemoDataSourceType) -> T {
        do {
            return try source.decoder.decode(
                T.self,
                from: loadFile(bundle: bundle, named: source.fileName, withExtension: source.fileExtension)
            )
        } catch {
            preconditionFailure(
                "Decoding error: expected one `\(T.Type.self)` object in the loaded asset. The decoding error is: \(error)"
            )
        }
    }

    // MARK: Helper function

    /// Loads an asset file for the bundle of the conforming class and the given file name.
    ///
    /// - Parameters:
    ///   - bundle: Bundle in which the file is located
    ///   - fileName: The file name of the asset (without extension)
    ///   - extension: The extension of the file
    /// - Returns: The data representation of the file
    fileprivate static func loadFile(bundle: Bundle, named fileName: String, withExtension extension: String) -> Data {
        guard let url = bundle.url(forResource: fileName, withExtension: `extension`),
              let fileData = try? Data(contentsOf: url)
        else {
            preconditionFailure(
                "Expected to find an asset named \"\(fileName)\" in" +
                    " the bundle with the following identifier: \(bundle.bundleIdentifier ?? "No identifier")."
            )
        }
        return fileData
    }
}

// MARK: DemoDataProviding + AnyObject
extension DemoDataProviding where Self: AnyObject {
    public static func fileData(from source: DemoDataSourceType) -> Data {
        self.loadFile(bundle: Bundle(for: Self.self), named: source.fileName, withExtension: source.fileExtension)
    }

    public static func demoObject<T: Decodable>(for type: T.Type, from source: DemoDataSourceType) -> T {
        self.demoObject(bundle: Bundle(for: Self.self), for: type, from: source)
    }

    public static func demoObjects<T: Decodable>(for type: T.Type, from source: DemoDataSourceType) -> [T] {
        self.demoObjects(bundle: Bundle(for: Self.self), for: type, from: source)
    }
}

// MARK: DemoDataProviding + Utils
extension ClosedRange where Bound == Double {
    var randomValue: Bound {
        .random(in: lowerBound ... upperBound)
    }
}

extension DemoDataProviding {
    /// Get a random delay in second and try to mimic the network latency.
    ///
    /// - Returns: A random number from 0.2 - 0.5 second.
    public var delay: TimeInterval {
        (0.2 ... 0.5).randomValue
    }
}
