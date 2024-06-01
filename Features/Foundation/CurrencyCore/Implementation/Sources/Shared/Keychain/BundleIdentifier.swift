//
//  BundleIdentifier.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

public struct BundleIdentifier {
    public let id: String
}

extension BundleIdentifier {
    // a crash is intended in case of absent bundleId
    public static let executable = Self(id: Bundle.main.bundleIdentifier!) // swiftlint:disable:this force_unwrapping
}
