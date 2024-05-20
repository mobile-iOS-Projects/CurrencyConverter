//
//  StringProtocol+Extensions.swift
//  watchOS
//
//  Created by Sergey Runovich on 6.05.24.
//

extension StringProtocol {
    public var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}
