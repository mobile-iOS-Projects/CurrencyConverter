//
//  ConversionScreenViewModel.swift
//  Conversion
//
//  Created by Siarhei Runovich on 10.06.24.
//

import Foundation
import Networking
import CurrencyCore
import Combine

@Observable
final class ConversionScreenViewModel {
    // MARK: - Published Properties
    var conversion: Loadable<[Currency], Error> = .initial
    var showErrorView: Bool = false
    var searchText = ""
    var activeTab: SortingTab = .defaultSort

    // MARK: - Private Properties
    private let networking = Networking()

    // MARK: - Computed Properties
    var isShimmering: Bool {
        switch conversion {
        case .initial:
            true
        case let .loading(lastValue):
            lastValue == nil
        default:
            false
        }
    }

    init() {
        getCurrencyData()
    }
}

// MARK: - Public Methods
extension ConversionScreenViewModel {
    func sortedCurrencies() -> [Currency] {
        guard !isShimmering else { return .placeholder }

        var filtered = conversion.value ?? []

        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.fullName.localizedCaseInsensitiveContains(searchText) || $0.code.localizedCaseInsensitiveContains(searchText)
            }
        }

        return switch activeTab {
        case .name:
            filtered.sorted { $0.fullName.rawValue < $1.fullName.rawValue }
        case .rateAscending:
            filtered.sorted { $0.rate < $1.rate }
        case .rateDescending:
            filtered.sorted { $0.rate > $1.rate }
        case .defaultSort:
            filtered
        }
    }

    func refreshConversion() {
        conversion = .loading

        getCurrencyData()
    }
}

// MARK: - Private Methods
extension ConversionScreenViewModel {
   private func getCurrencyData() {
        Task {
            try await Task.sleep(seconds: 3)
            do {
                let results = try await networking.getRequest(
                    endpoint: CurrencyEndpoints.getCurrencies(
                        countryCode: CurrencyCountryType.unitedStatesDollar.rawValue
                    ),
                    responseModel: CurrencyData.self
                )
                let currency = CurrencyCountryType.allCases
                    .filter { $0 != CurrencyCountryType.unitedStatesDollar }
                    .map {
                        Currency(id: $0.rawValue, code: $0.rawValue, rate: results.rates.getRate(of: $0.rawValue))
                    }
                conversion = .value(currency)
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }
}
