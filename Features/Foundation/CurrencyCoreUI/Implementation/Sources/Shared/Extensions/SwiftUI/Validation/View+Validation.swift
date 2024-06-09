//
//  View+Validation.swift
//  SMSCoreUI
//
//  Created by Weiß, Alexander on 24.09.22.
//

#if os(iOS) || os(visionOS)

import SwiftUI

struct ValidationModifier: ViewModifier {
    @State var latestValidation: ValidationResult = .success

    let validationPublisher: ValidationPublisher

    func body(content: Content) -> some View {
        HStack {
            VStack(alignment: .leading) {
                content
                validationMessage
            }
            validationIcon
        }.onReceive(validationPublisher) { validation in
            self.latestValidation = validation
        }
    }

    @ViewBuilder
    var validationMessage: some View {
        switch latestValidation {
        case .success:
            EmptyView()
        case let .failure(message):
            Text(message)
            #if os(visionOS)
                .font(.preferredSMSFont(for: .caption, weight: .regular))
            #else
//                .foregroundColor(.preferredSMSColor(for: .red6))
                .font(.preferredSMSFont(for: .caption1, weight: .regular))
            #endif
        }
    }

    @ViewBuilder
    var validationIcon: some View {
        switch latestValidation {
        case .success:
            Image(systemName: "checkmark.circle.fill").foregroundColor(.blue)
        case .failure:
            Image(systemName: "exclamationmark.circle.fill")
            #if os(iOS)
                .foregroundColor(.blue)
            #endif
        }
    }
}

extension View {
    public func validation(_ validationPublisher: ValidationPublisher) -> some View {
        self.modifier(ValidationModifier(validationPublisher: validationPublisher))
    }
}

#endif
