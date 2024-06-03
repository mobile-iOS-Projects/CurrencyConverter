//
//  SettingsScreen.swift
//  SettingsScreenAPI
//
//  Created by Sergey Runovich on 6.05.24.
//

import SwiftUI

public struct SettingsScreen: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            Rectangle().foregroundStyle(Color.yellow)
            Text("SettingsScreen").frame(height: 100)
            Rectangle().foregroundStyle(Color.yellow)
        }
    }
}

#Preview {
    SettingsScreen()
}
