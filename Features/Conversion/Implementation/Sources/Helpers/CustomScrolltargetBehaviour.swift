//
//  CustomScrolltargetBehaviour.swift
//  Conversion
//
//  Created by Siarhei Runovich on 11.06.24.
//

import SwiftUI

struct CustomScrolltargetBehaviour: ScrollTargetBehavior {
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        if target.rect.minY < 70 {
            if target.rect.minY < 35 {
                target.rect.origin = .zero
            } else {
                target.rect.origin = .init(x: 0, y: 70)
            }
        }
    }
}
