//
//  String+Extensions.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

// MARK: - Regex
extension String {
    public func matches(regex: String) -> [String] {
        ranges(regex: regex).map { String(self[$0]) }
    }

    public func ranges(regex: String) -> [Range<String.Index>] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self, range: NSRange(self.startIndex..., in: self))
            return results.compactMap {
                if let range = Range($0.range, in: self) {
                    return range
                }
                return nil
            }
        } catch {
            return []
        }
    }
}

// MARK: - Count of specific character
extension String {
    /// Count the occurances of the given character
    ///
    /// - Complexity: O(n) where `n` is the length of the string
    /// - Parameters:
    ///   - needle: Character to search for
    /// - Returns: Number of how often the searched character occurs
    public func count(of needle: Character) -> Int {
        reduce(0) {
            $1 == needle ? $0 + 1 : $0
        }
    }
}

// MARK: - RawRepresentable
extension String: RawRepresentable {
    public var rawValue: String {
        self
    }

    public init?(rawValue: String) {
        self = rawValue
    }
}

// MARK: - isEmpty Unwrapped
extension String? {
    public var isEmpty: Bool {
        switch self {
        case .none:
            return true
        case let .some(wrapped):
            return wrapped.isEmpty
        }
    }
}

// MARK: - Random string
extension String {
    /// Create a string of random characters with the specified length
    /// - Parameters:
    ///   - length: The length of the resulting string
    /// - Returns: A random string instance
    public static func random(length: Int = 15) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        return String((0 ..< length).map { _ in base.randomElement() ?? "a" })
    }
}

// MARK: - Truncate
extension String {
    /// Truncate to a given `length` with a given `trailing` string
    ///
    /// The `length` count takes the `trailing` length count into considering
    ///
    /// - Parameters:
    ///   - length: Length of the final string
    ///   - trailing: Trailing string indicating the truncation. "..." per default
    /// - Returns: A trucnated string
    public func truncate(to length: Int, trailing: String = "…") -> String {
        if self.count > length {
            return self.prefix(max(0, length - trailing.count)) + trailing
        } else {
            return self
        }
    }
}
