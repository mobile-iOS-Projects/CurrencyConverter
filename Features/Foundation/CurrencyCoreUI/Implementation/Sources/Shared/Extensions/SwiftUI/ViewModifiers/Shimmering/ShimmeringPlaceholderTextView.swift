//
//  ShimmeringPlaceholderTextView.swift
//  SMSCoreUI
//
//  Created by Steinmetz, Conrad on 13.02.23.
//

import SwiftUI

public struct ShimmeringPlaceholderTextView: View {
    public var body: some View {
        Text("---- ---- ---- ---- ----- ---- ----")
            .frame(height: 14)
            .font(.footnote)
//            .foregroundColor(.preferredSMSColor(for: .secondaryLabel))
            .lineLimit(1)
//            .background(Color.preferredSMSColor(for: .secondaryLabel))
            .clipShape(Capsule())
            .shimmering()
            .accessibilityHidden(true)
    }

    public init() { /* Public to access from other modules*/ }
}

struct ShimmeringPlaceholderTextView_Previews: PreviewProvider {
    static var previews: some View {
        ShimmeringPlaceholderTextView()
    }
}
