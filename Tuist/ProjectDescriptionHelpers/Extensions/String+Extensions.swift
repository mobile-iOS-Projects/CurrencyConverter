//
//  String+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }

    /// A "PascalCase" representation of the string
    var pascalCased: String {
        return lowercased()
            .split(separator: " ")
            .map { $0.lowercased().capitalizingFirstLetter() }
            .joined()
    }

    /// A "camelCase" representation of the string
    var camelCased: String {
        let upperCased = pascalCased
        return upperCased.prefix(1).lowercased() + upperCased.dropFirst()
    }
}
