//
//  SavedCurrency.swift
//  Conversion
//
//  Created by Siarhei Runovich on 11.06.24.
//

import SwiftData
import SwiftUI

@Model 
final public class SavedCurrency {
    @Attribute(.unique) public let id: String
    let code: String
    let rate: Double
    
    public init(id: String, code: String, rate: Double) {
        self.id = id
        self.code = code
        self.rate = rate
    }
}
