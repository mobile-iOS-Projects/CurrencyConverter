//
//  AccessGroup.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

public struct AccessGroup {
    private let suffix = "com.sap.mobile.apps.SharedItems"
    private let teamIdKey = "Team_Id"
    private let bundleId: String

    public private(set) var teamId: String

    public var id: String {
        "\(teamId).\(suffix)"
    }

    public init(bundleId: String) {
        self.bundleId = bundleId
        guard let value = Bundle(identifier: self.bundleId)?.object(forInfoDictionaryKey: teamIdKey) as? String else {
            fatalError("The bundle identifier seems to be invalid. This is a serious configuration error.")
        }
        teamId = value
    }
}
