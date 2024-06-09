//
//  AppExtensionHelpers.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

public func IS_IN_APP_EXTENSION() -> Bool {
    let bundleUrl: URL = Bundle.main.bundleURL
    let bundlePathExtension: String = bundleUrl.pathExtension
    return bundlePathExtension == "appex"
}
