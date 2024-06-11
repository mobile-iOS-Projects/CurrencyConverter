//
//  CurrencyView.swift
//  Walut
//
//  Created by Marcin Bartminski on 13/10/2022.
//

import CurrencyCoreUI
import SwiftUI

struct CurrencyView: View {
    // The currency object that holds information about
    // a specific currency
    let currency: Currency

    // A boolean flag to indicate whether the view should
    // display a shimmering effect, often used for loading placeholders
    let isShimmering: Bool

    var body: some View {
        HStack(spacing: 15) {
            flagView
            detailsView
            Spacer()
            rateView
        }
        .padding()
        .background(backgroundView)
        .cornerRadius(12)
        .shadow(radius: 5)
        .redacted(reason: isShimmering ? .placeholder : [])
        .shimmering(active: isShimmering)
    }
}

// MARK: - Subviews
extension CurrencyView {
    @ViewBuilder
    private var flagView: some View {
        Text(currency.flag)
            .font(.largeTitle)
            .shadow(radius: 5)
    }

    @ViewBuilder
    private var detailsView: some View {
        VStack(alignment: .leading) {
            Text(currency.fullName)
                .font(.headline)
                .foregroundColor(.primary)

            Text(currency.code)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }

    @ViewBuilder
    private var rateView: some View {
        Text(String(format: "%.2f", currency.rate))
            .font(.title)
            .bold()
            .foregroundColor(.black)
    }

    @ViewBuilder
    private var backgroundView: some View {
        isShimmering ? Color.gray.opacity(0.25) : Color.teal.opacity(0.25)
    }
}

// MARK: - Preview
#Preview(body: {
    CurrencyView(currency: Currency(id: UUID().uuidString, code: "USD", rate: 2.434), isShimmering: true)
})
