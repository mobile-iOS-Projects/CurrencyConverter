//
//  Array+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by Weiss, Alexander on 07.02.22.
//

import Foundation
import ProjectDescription

extension Array where Element: Sequence {
    /// Join an array of sequences into one array
    ///
    /// - Returns: A joined array
    public func joined() -> [Element.Element] {
        return self.reduce([], +)
    }
}
