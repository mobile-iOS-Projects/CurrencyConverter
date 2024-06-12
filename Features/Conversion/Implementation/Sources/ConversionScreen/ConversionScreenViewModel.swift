//
//  ConversionScreenViewModel.swift
//  Conversion
//
//  Created by Siarhei Runovich on 10.06.24.
//

import Combine
import CurrencyCore
import Foundation
import Networking
import SwiftData
import Factory

final public class ConversionScreenViewModel: ObservableObject {
    @Injected(\.networkMonitorAPI) private var networkMonitorAPI
    @Injected(\.networkingAPI) private var networkingAPI

    // MARK: - Published Properties
    @Published var conversion: Loadable<[Currency], Error> = .initial
    @Published var showErrorView: Bool = false
    @Published var searchText = ""
    @Published var activeTab: SortingTab = .defaultSort

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

    // MARK: - Initialise
    public init() {
        getCurrencyData()
        print("init ConversionScreenViewModel")
    }

    deinit {
        print("deinit ConversionScreenViewModel")
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
        guard networkMonitorAPI.isConnected else { return }

        Task {
            try await Task.sleep(seconds: 3)
            do {
                let results = try await networkingAPI.getRequest(
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
                await MainActor.run {
                    conversion = .value(currency)
                }
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
    }

    func saveCurrencies(data: [Currency], to modelContext: ModelContext) {
        guard networkMonitorAPI.isConnected else { return }

        let savedCurrencies = try? modelContext.fetch(FetchDescriptor<SavedCurrency>())
        savedCurrencies?.forEach { modelContext.delete($0) }

        data.forEach { item in
            let newSaved = SavedCurrency(id: item.code, code: item.code,  rate: item.rate)
            modelContext.insert(newSaved)
            print("Saved \(item.code) to SwiftData")
        }
    }

    func getCurrencies(from modelContext: ModelContext) {
        guard !networkMonitorAPI.isConnected else { return }

        do {
            let savedCurrencies = try modelContext.fetch(FetchDescriptor<SavedCurrency>())

            let currency = savedCurrencies
                .map { Currency(id: $0.id, code: $0.code, rate: $0.rate) }

            conversion = .value(currency)
        } catch {
            print("Error: Fetching currencies failed")
        }
    }
    
}
