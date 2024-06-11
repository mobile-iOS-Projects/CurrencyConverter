//
//  CurrencyCell.swift
//  Walut
//
//  Created by Marcin Bartminski on 13/10/2022.
//

import SwiftUI

struct CurrencyCell: View {
    let currency: Currency

    var body: some View {
        HStack(spacing: 15) {
            Text(currency.flag)
                .font(.largeTitle)
                .shadow(radius: 5)

            VStack(alignment: .leading) {
                Text(currency.fullName)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(currency.code)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text(String(format: "%.2f", currency.rate))
                .font(.title)
                .bold()
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.teal.opacity(0.25))
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

#Preview(body: {
    CurrencyCell(currency: Currency(code: "USD", rate: 2.434))
})
