//
//  HTTPURLResponse+Extension.swift
//  Networking
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

extension HTTPURLResponse {
    var isSuccess: Bool {
        200 ..< 300 ~= self.statusCode
    }

    var isRedirect: Bool {
        300 ..< 400 ~= self.statusCode
    }

    var isFailed: Bool {
        !(self.isSuccess || self.isRedirect)
    }
}
