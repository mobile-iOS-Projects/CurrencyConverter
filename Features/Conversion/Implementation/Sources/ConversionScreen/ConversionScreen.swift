//
//  ConversionScreen.swift
//  Conversion
//
//  Created by Siarhei Runovich on 3.06.24.
//

import CurrencyCoreUI
import SwiftUI

public struct ConversionScreen: View {

    public init() {}

    public var body: some View {
        VStack {
            Rectangle().foregroundStyle(Color.red)
            Text("ConversionScreen").frame(height: 100)
            Image(currencyIllustration: .simpleConnection, option: .noInternetConnection)
            Rectangle().foregroundStyle(Color.red)
        }
    }
}

#Preview {
    ConversionScreen()
}
