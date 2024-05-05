//
//  String+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Weiss, Alexander on 23.01.22.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }

    /// A "PascalCase" representation of the string
    var pascalCased: String {
        return self.lowercased()
            .split(separator: " ")
            .map { return $0.lowercased().capitalizingFirstLetter() }
            .joined()
    }

    /// A "camelCase" representation of the string
    var camelCased: String {
        let upperCased = self.pascalCased
        return upperCased.prefix(1).lowercased() + upperCased.dropFirst()
    }
}
