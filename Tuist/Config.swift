//
//  Config.swift
//  ProjectDescriptionHelpers
//
//  Created by Weiss, Alexander on 11.01.22.
//

import ProjectDescription

let config = Config(
     compatibleXcodeVersions: [.exact("15.3.0")]
    // cache: .cache(
    //     profiles: [
    //         .profile(name: "Simulator", configuration: "Development") // Important to name the configuration the same as our ones. Otherwise tuist will not correctly locate built artifacts and does not cache them correctly.
    //     ],
    //     path: .relativeToRoot(".tuist-cache")
    // )
)
