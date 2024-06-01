//
//  WKWebsiteDataStore+Extensions.swift
//  SMSCoreUI
//
//  Created by Dzianis Zaitsau on 14.02.23.
//

#if os(iOS) || os(visionOS)

import SMSCore
import WebKit

extension WKWebsiteDataStore {
    private enum Constants {
        /// A key to be used for storing/fetching `HTTPCookie` instances from the `Keychain`
        static let cookiesKeychainKey = "com.sap.start.coreui.websitedatastore.cookies"
    }

    /// Stores all the session cookies into the keychain for a certain key
    ///
    /// - Parameters:
    ///   - keychain: a `Keychain` instance to be used
    @MainActor
    public func storeSessionCookies(into keychain: Keychain) async throws {
        let cookies = await httpCookieStore.allCookies().filter(\.isSessionOnly)
        let data = try NSKeyedArchiver.archivedData(withRootObject: cookies, requiringSecureCoding: false)
        try keychain.set(data, forKey: Constants.cookiesKeychainKey)
    }

    /// Restores all the session cookies from the keychain for a certain key
    ///
    /// - Parameters:
    ///   - keychain: a `Keychain` instance to be used
    @MainActor
    public func restoreSessionCookies(from keychain: Keychain) async throws {
        let data: Data
        do {
            data = try keychain.get(Constants.cookiesKeychainKey)
        } catch let error as KeychainError {
            if case let .readFailed(readingError) = error,
               readingError == .itemMissing
            {
                // The keychain’s storage does not have cookies
                // so that no error should be thrown
                return
            }
            throw error
        } catch {
            throw error
        }
        let unarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
        // Manually disable secure coding
        // Note: it must match the archiver from `storeSessionCookies(into:)`
        unarchiver.requiresSecureCoding = false
        guard let cookies = unarchiver.decodeObject(
            forKey: NSKeyedArchiveRootObjectKey
        ) as? [HTTPCookie] else { return }

        for cookie in cookies {
            await httpCookieStore.setCookie(cookie)
        }
    }
}

#endif
