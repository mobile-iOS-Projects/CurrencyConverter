//
//  SharedAppGroup.swift
//  SMSCore
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

public enum SharedAppGroup {
    case sharedUserDefaults

    public var id: String {
        switch self {
        case .sharedUserDefaults:
            guard let value = Bundle.main.object(forInfoDictionaryKey: "App_Group_Id") as? String else {
                fatalError("The app group identifier seems to be missing. This is a serious configuration error.")
            }
            return value
        }
    }
}
