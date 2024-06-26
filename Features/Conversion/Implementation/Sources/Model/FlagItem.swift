//
//  FlagItem.swift
//  Conversion
//
//  Created by Siarhei Runovich on 25.06.24.
//

import SwiftUI

struct FlagItem: Identifiable, Hashable {
    private(set) var id: UUID = .init()
    var title: String
    var image: UIImage?
}

var flagsImages: [FlagItem] = [
    .init(title: "Belarusian Flag", image: UIImage(resource: .bel)),
    .init(title: "Euro Flag", image: UIImage(resource: .eur)),
    .init(title: "Poland Flag", image: UIImage(resource: .pol)),
    .init(title: "Russian Flag", image: UIImage(resource: .rus)),
    .init(title: "Ukranian Flag", image: UIImage(resource: .ukr)),
    .init(title: "USA Flag", image: UIImage(resource: .usa))
]
