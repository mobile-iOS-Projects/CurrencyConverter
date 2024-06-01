//
//  UnwrapView.swift
//  SMSCoreUI
//
//  Created by Steinmetz, Conrad on 19.07.22.
//

import SwiftUI

/// Wrapper for optional SwiftUI views
public struct UnwrapView<Value, Content: View>: View {
    private let value: Value?
    private let contentProvider: (Value) -> Content

    public var body: some View {
        value.map(contentProvider)
    }

    public init(_ value: Value?, @ViewBuilder content: @escaping (Value) -> Content) {
        self.value = value
        contentProvider = content
    }
}
