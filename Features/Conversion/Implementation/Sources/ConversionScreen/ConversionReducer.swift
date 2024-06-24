//
//  ConversionReducer.swift
//  Conversion
//
//  Created by Siarhei Runovich on 17.06.24.
//

import SwiftUI
import ComposableArchitecture
import CurrencyCore
import Factory
import Networking
import SwiftData

extension ConversionReducer {
    @Reducer
    public enum Path {
        case recentSearchScreen(RecentsSearchReducer)
        case statisticScreen(StatisticReducer)
    }
}

@Reducer
public struct ConversionReducer {

    @Injected(\.networkingAPI) private var networkingAPI
    @Injected(\.networkMonitorAPI) private var networkMonitorAPI

    public init() {
    }

    @ObservableState
    public struct State {
        @Presents var сonversionDetails: ConversionDetailsReducer.State?

        var recentSearch = RecentsSearchReducer.State()
        var statisticScreen = StatisticReducer.State()
        
        var viewState: Loadable<[Currency], Error> = .initial
        var searchText = ""
        var activeTab: SortingTab = .defaultSort
        var sortedCurrencies: [Currency] = .placeholder
        var path = StackState<Path.State>()
   
        var isShimmering: Bool {
            switch viewState {
            case .initial:
                true
            case let .loading(lastValue):
                lastValue == nil
            default:
                false
            }
        }
        
        public init() {
            
        }
    }

    public enum Action {
        case сonversionDetails(PresentationAction<ConversionDetailsReducer.Action>)
        case openConversionDetailsView
        
        case recentSearchActioon(RecentsSearchReducer.Action)
        case openRecentSearchView
        
        case statisticAction(StatisticReducer.Action)
        case openStatistichView

        case onViewDidLoad
        case changeViewState(Loadable<[Currency], Error>)
        case changeActiveTab(SortingTab)
        case updateSearchText(String)
        case refreshConversion
        case path(StackActionOf<Path>)
    }

    public var body: some ReducerOf<Self> {
        Scope(state: \.recentSearch, action: \.recentSearchActioon) {
            RecentsSearchReducer()
        }
        
        Scope(state: \.statisticScreen, action: \.statisticAction) {
            StatisticReducer()
        }

        Reduce { state, action in
            switch action {
            case let .recentSearchActioon(action):
                switch action {
                case .testction:
                    print("recentSearchActioon")
                    state.path.append(.statisticScreen(StatisticReducer.State()))
                    return .none
                }
            case let .statisticAction(action):
                switch action {
                case .testction:
                    state.path.removeAll()
                    return .none
                }
            case .openConversionDetailsView:
                state.сonversionDetails = ConversionDetailsReducer.State()
                return .none
            case .openRecentSearchView:
                state.path.append(.recentSearchScreen(RecentsSearchReducer.State()))
                return .none
            case .onViewDidLoad:
                return .run { send in
                    do {
                        let currency = try await getCurrencyData()
                        await send(.changeViewState(.value(currency)))
                    } catch {
                        await send(.changeViewState(.error(error)))
                    }
                }
            case let .changeViewState(value):
                state.viewState = value
                state.sortedCurrencies = sortedCurrencies(state: state)
                return .none
            case let .changeActiveTab(tab):
                state.activeTab = tab
                state.sortedCurrencies = sortedCurrencies(state: state)
                return .none
            case let .updateSearchText(text):
                state.searchText = text
                state.sortedCurrencies = sortedCurrencies(state: state)
                return .none
            case .refreshConversion:
                state.viewState = .loading
                return .send(.onViewDidLoad)
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension ConversionReducer {
    private func getCurrencyData() async throws -> [Currency]  {
        try await Task.sleep(seconds: 3)
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
        return currency
    }

    func sortedCurrencies(state: State) -> [Currency] {
        guard !state.isShimmering else { return .placeholder }

        guard var filtered = state.viewState.value else { return [] }
        
        if !state.searchText.isEmpty {
            filtered = filtered.filter {
                $0.fullName.localizedCaseInsensitiveContains(state.searchText) || $0.code.localizedCaseInsensitiveContains(state.searchText)
            }
        }

        return switch state.activeTab {
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
    
    func saveCurrencies(data: [Currency], to modelContext: ModelContext) {
//        guard networkMonitorAPI.isConnected else { return }
//
//        let savedCurrencies = try? modelContext.fetch(FetchDescriptor<SavedCurrency>())
//        savedCurrencies?.forEach { modelContext.delete($0) }
//
//        data.forEach { item in
//            let newSaved = SavedCurrency(id: item.code, code: item.code,  rate: item.rate)
//            modelContext.insert(newSaved)
//            print("Saved \(item.code) to SwiftData")
//        }
    }

    func getCurrencies(from modelContext: ModelContext) {
//        guard !networkMonitorAPI.isConnected else { return }
//
//        do {
//            let savedCurrencies = try modelContext.fetch(FetchDescriptor<SavedCurrency>())
//
//            let currency = savedCurrencies
//                .map { Currency(id: $0.id, code: $0.code, rate: $0.rate) }
//
//            conversion = .value(currency)
//        } catch {
//            print("Error: Fetching currencies failed")
//        }
    }
}
