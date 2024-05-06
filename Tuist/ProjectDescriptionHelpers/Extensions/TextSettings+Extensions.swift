//
//  TextSettings+Extensions.swift
//  ProjectDescriptionHelpers
//
//  Created by Sergey Runovich on 6.05.24.
//

import Foundation
import ProjectDescription

extension ProjectDescription.Project.Options.TextSettings {
    /// SMS project specific text settings for Xcode projects
    ///
    /// Applies text settings that are matching the rules we defined in `./.swiftformat` files
    /// * No tab character usage
    /// * Tab width is 4 white spaces
    ///
    /// Related swiftformat rules are:
    /// * --indent 4
    public static var currencyConverterTextSettings: Self {
        return .textSettings(
            usesTabs: false,
            indentWidth: 4,
            wrapsLines: false
        )
    }
}
