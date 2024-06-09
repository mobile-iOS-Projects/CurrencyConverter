//
//  NewsScreen.swift
//  NewsAPI
//
//  Created by Sergey Runovich on 6.05.24.
//

import SwiftUI

public struct NewsScreen: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            Rectangle().foregroundStyle(Color.green)
            Text("NewsScreen").frame(height: 100)
            Rectangle().foregroundStyle(Color.green)
        }
    }
}

#Preview {
    NewsScreen()
}
