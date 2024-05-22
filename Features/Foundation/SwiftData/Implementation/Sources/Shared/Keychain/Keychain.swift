//
//  Keychain.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation
import Security

public class Keychain {
    // MARK: - Public Properties
    public let accessGroup: String?

    // MARK: - Private Properties

    private lazy var jsonEncoder = JSONEncoder()
    private lazy var jsonDecoder = JSONDecoder()

    private static let syncQueueIdentifier = DispatchSpecificKey<Void>()
    private let syncQueue: DispatchQueue

    // MARK: - Initializers
    public init(accessGroup: String? = nil) {
        self.accessGroup = accessGroup
        self.syncQueue = DispatchQueue(label: "\(Bundle.current.bundleIdentifier ?? "").keychain")
        self.syncQueue.setSpecific(key: Keychain.syncQueueIdentifier, value: ())
    }
}

// MARK: - Saving
extension Keychain {
    public func set(_ value: String, forKey key: String) throws {
        guard let value = value.data(using: .utf8) else {
            throw KeychainError.encodingFailed(message: "Value cannot be converted to Data")
        }

        try self.set(value, forKey: key)
    }

    public func set(_ value: Bool, forKey key: String) throws {
        let value = Data(value ? [1] : [0])

        try self.set(value, forKey: key)
    }

    public func set(_ value: some Encodable, forKey key: String) throws {
        var jsonValue = Data()

        do {
            jsonValue = try self.jsonEncoder.encode(value)
        } catch {
            throw KeychainError.encodingFailed(message: error.localizedDescription)
        }

        try self.set(jsonValue, forKey: key)
    }

    public func set(_ value: Data, forKey key: String) throws {
        try runOnSync {
            try delete(key: key) // Delete any existing key before saving it

            var query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecAttrService: key,
                kSecValueData: value,
                kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
            ]

            appendAccessGroupIfNeeded(&query)
            let resultCode = SecItemAdd(query as CFDictionary, nil)

            guard resultCode == noErr else {
                throw KeychainError.storeFailed(status: resultCode)
            }
        }
    }
}

// MARK: - Reading
extension Keychain {
    public func get(_ key: String) throws -> String {
        let data: Data = try self.get(key)

        guard let string = String(data: data, encoding: .utf8) else {
            throw KeychainError.readFailed(error: .unknown(status: errSecInvalidEncoding))
        }

        return string
    }

    public func get(_ key: String) throws -> Bool {
        let data: Data = try self.get(key)

        guard let bit = data.first else {
            throw KeychainError.readFailed(error: .unknown(status: errSecInvalidEncoding))
        }

        return bit == 1
    }

    public func get<T>(_ key: String) throws -> T where T: Decodable {
        let data: Data = try self.get(key)

        do {
            return try self.jsonDecoder.decode(T.self, from: data)
        } catch {
            throw KeychainError.decodingFailed(message: error.localizedDescription)
        }
    }

    public func get(_ key: String) throws -> Data {
        try runOnSync {
            var query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecAttrService: key,
                kSecReturnData: true,
                kSecMatchLimit: kSecMatchLimitOne,
                kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
            ]
            appendAccessGroupIfNeeded(&query)

            var dataReference: CFTypeRef?

            // Copy item from keychain into reference and save its result code
            let resultCode = SecItemCopyMatching(query as CFDictionary, &dataReference)

            guard resultCode == noErr else {
                if resultCode == errSecItemNotFound {
                    // This error may occur in case the keychain's storage does
                    // not have an item or a query for fetching an item is not
                    // correct (some attributes are missing or incorrect)
                    // To differenciate the cases above we can fetch all the keys
                    // from the keychain and check whether we have a specific one
                    if allKeys().contains(key) {
                        throw KeychainError.readFailed(error: .incorrectQuery)
                    } else {
                        throw KeychainError.readFailed(error: .itemMissing)
                    }
                } else {
                    throw KeychainError.readFailed(error: .unknown(status: resultCode))
                }
            }

            guard let data = dataReference as? Data else {
                throw KeychainError.readFailed(error: .unknown(status: errSecInvalidEncoding))
            }

            return data
        }
    }
}

// MARK: - Deleting
extension Keychain {
    public func delete(key: String) throws {
        try runOnSync {
            var query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecAttrService: key,
            ]
            appendAccessGroupIfNeeded(&query)

            let resultCode = SecItemDelete(query as CFDictionary)
            guard resultCode == noErr || resultCode == errSecItemNotFound else {
                throw KeychainError.deleteFailed(status: resultCode)
            }
        }
    }

    public func wipe() throws {
        try runOnSync {
            var query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
            ]
            appendAccessGroupIfNeeded(&query)

            let resultCode = SecItemDelete(query as CFDictionary)

            guard resultCode == noErr || resultCode == errSecItemNotFound else {
                throw KeychainError.deleteFailed(status: resultCode)
            }
        }
    }
}

// MARK: - General
extension Keychain {
    /// Retrieve all keys that were saved by using a custom `Keychain` instance
    ///
    /// - Attention: If keys are saved not using the `Keychain` type, it is not guranteed these keys will be returned by this
    /// method
    /// - Returns: Array of keys in the Keychain
    public func allKeys() -> [String] {
        // Create the query
        var query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true,
            kSecReturnAttributes: true,
            kSecReturnRef: true,
            kSecMatchLimit: kSecMatchLimitAll,
            kSecAttrAccessible: kSecAttrAccessibleAfterFirstUnlock,
        ]
        appendAccessGroupIfNeeded(&query)

        var dataReference: CFTypeRef?

        // Copy item from keychain into reference and save its result code
        let resultCode = SecItemCopyMatching(query as CFDictionary, &dataReference)

        var keys: [String] = .init()

        // Verify return type
        guard resultCode == noErr,
              let array = dataReference as? [[String: Any]]
        else {
            return keys
        }

        // Read out keys
        for item in array {
            if let key = item[kSecAttrAccount as String] as? String {
                keys.append(key)
                // including identities and certificates in dictionary
            } else if let key = item[kSecAttrLabel as String] as? String {
                keys.append(key)
            }
        }

        return keys
    }
}

// MARK: - Helpers
extension Keychain {
    /// Appends `self.accessGroup` to the given dictionary if `self.accessGroup` != nil
    ///
    /// - Parameters
    ///   - items: Dictionary to append `self.accessGroup` to
    private func appendAccessGroupIfNeeded(_ items: inout [CFString: Any]) {
        guard let accessGroup = self.accessGroup else { return }

        items[kSecAttrAccessGroup] = accessGroup
    }

    func runOnSync<T>(_ block: () throws -> T) rethrows -> T {
        DispatchQueue.getSpecific(key: Keychain.syncQueueIdentifier) != nil ? try block() : try syncQueue.sync(execute: block)
    }
}

extension Keychain {
    /// Shared keychain instance which always uses the "TEAM_ID".com.sap.mobile.apps.SharedItems as its access group
    /// "TEAM_ID" must be present in the INFO.plist of the executable that uses this instance
    public static var accessGroup = Keychain(accessGroup: AccessGroup(bundleId: BundleIdentifier.executable.id).id)
}
