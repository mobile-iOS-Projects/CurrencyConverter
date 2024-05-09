//
//  Array+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation
import ProjectDescription

public extension Array where Element: Sequence {
    /// Join an array of sequences into one array
    ///
    /// - Returns: A joined array
    func joined() -> [Element.Element] {
        return reduce([], +)
    }
}
