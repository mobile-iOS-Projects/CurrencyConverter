//
//  ConversionView.swift
//  Conversion
//
//  Created by Siarhei Runovich on 3.06.24.
//

import ComposableArchitecture
import CurrencyCore
import CurrencyCoreUI
import Env
import SwiftData
import SwiftUI

public struct ConversionView: View {
    @Bindable var store: StoreOf<ConversionReducer>

    // MARK: - FocusState Properties
    @FocusState private var isSearching: Bool

    // MARK: - Environment Properties
    @Environment(\.colorScheme) private var scheme
    @Environment(\.modelContext) private var modelContext

    // MARK: - Namespace Properties
    @Namespace private var animation

    // MARK: - Private Properties

    // Nav Bar Height includes all paddings and calculations
    let navBarHeight: CGFloat = 190

    // Search Bar Height
    let searchBarViewHeight: CGFloat = 45

    // MARK: - Initialise
    public init(store: StoreOf<ConversionReducer>) {
        self.store = store
    }

    // MARK: - Body
    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ScrollView(.vertical) {
                LazyVStack(spacing: 15) {
                    if store.sortedCurrencies.isEmpty {
                        VStack {
                            Text("Nothing found")
                            Text("Try a different search")
                        }
                    } else {
                        currencyView()
                            .onTapGesture {
                                store.send(.openConversionDetailsView)
                            }
                            .onLongPressGesture {
                                store.send(.openRecentSearchView)
                            }
                    }
                }
                .safeAreaPadding(15)
                .safeAreaInset(edge: .top, spacing: 0) {
                    expandableNavigationBar()
                }
                .animation(.snappy(duration: 0.3, extraBounce: 0), value: isSearching)
            }
            .scrollTargetBehavior(CustomScrolltargetBehaviour())
            .background(.gray.opacity(0.15))
            .contentMargins(.top, navBarHeight, for: .scrollIndicators)
            .disabled(store.isShimmering)
            .onAppear {
                store.send(.onViewDidLoad)
            }
            .refreshable {
                store.send(.refreshConversion)
            }
            .toolbar(.hidden, for: .navigationBar)
        } destination: { key in
            switch key.case {
            case let .recentSearchScreen(test):
                RecentsSearchView(store: store.scope(state: \.recentSearch, action: \.recentSearchActioon))
            case let .statisticScreen(test):
                StatisticView(store: store.scope(state: \.statisticScreen, action: \.statisticAction))
            }
        }
        .sheet(
            item: $store.scope(state: \.сonversionDetails, action: \.сonversionDetails)
        ) { store in
            ConversionDetailsView(store: store)
        }
    }
}

// MARK: - Expandable Navigation Bar
extension ConversionView {
    @ViewBuilder
    private func expandableNavigationBar() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
            let scrollViewHeight = proxy.bounds(of: .scrollView(axis: .vertical))?.height ?? 0
            let scaleProgress = calculateScaleProgress(minY: minY, scrollViewHeight: scrollViewHeight)
            let progress = calculateProgress(minY: minY)

            VStack(spacing: 10) {
                titleView(scaleProgress: scaleProgress)
                searchBarView(progress: progress)
                segmentedPickerView()
            }
            .padding(.top, 25)
            .safeAreaPadding(.horizontal, 15)
            .offset(y: calculateVerticalOffset(minY: minY, progress: progress))
        }
        .frame(height: navBarHeight)
        .padding(.bottom, calculateBottomPadding())
    }

    // Calculate the scale progress for the title
    private func calculateScaleProgress(minY: CGFloat, scrollViewHeight: CGFloat) -> CGFloat {
        minY > 0 ? 1 + (max(min(minY / scrollViewHeight, 1), 0) * 0.5) : 1
    }

    // Calculate the progress for the search bar animation
    private func calculateProgress(minY: CGFloat) -> CGFloat {
        isSearching ? 1 : max(min(-minY / 70, 1), 0)
    }

    // Calculate the vertical offset based on scroll position and search status
    private func calculateVerticalOffset(minY: CGFloat, progress: CGFloat) -> CGFloat {
        (minY < 0 || isSearching ? -minY : 0) - (progress * 65)
    }

    // Calculate the bottom padding based on search status
    private func calculateBottomPadding() -> CGFloat {
        10 + (isSearching ? -65 : 0)
    }

    @ViewBuilder
    private func titleView(scaleProgress: CGFloat) -> some View {
        Text("\(CurrencyCountryType.unitedStatesDollar.fullName) \(CurrencyCountryType.unitedStatesDollar.emoji)")
            .font(.largeTitle.bold())
            .scaleEffect(scaleProgress, anchor: .topLeading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 10)
    }

    @ViewBuilder
    private func searchBarView(progress: CGFloat) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.title3)
            TextField("Search Countries", text: Binding(get: {
                store.searchText
            }, set: { value in
                store.send(.updateSearchText(value))
            }))
            .focused($isSearching)

            if isSearching {
                Button(action: {
                    isSearching = false
                    store.send(.updateSearchText(""))
                }) {
                    Image(systemName: "xmark")
                        .font(.title3)
                }
                .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
            }
        }
        .foregroundStyle(Color.primary)
        .padding(.vertical, 10)
        .padding(.horizontal, 15 - (progress * 15))
        .frame(height: searchBarViewHeight)
        .clipShape(Capsule())
        .background {
            RoundedRectangle(cornerRadius: 25 - (progress * 25))
                .fill(.background)
                .shadow(color: .gray.opacity(0.25), radius: 5, x: 0, y: 5)
                .padding(.top, -progress * navBarHeight)
                .padding(.bottom, -progress * 65)
                .padding(.horizontal, -progress * 15)
        }
    }

    @ViewBuilder
    private func segmentedPickerView() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                ForEach(SortingTab.allCases, id: \.rawValue) { tab in
                    Button(action: {
                        store.send(.changeActiveTab(tab), animation: .snappy)
                    }) {
                        Text(tab.rawValue)
                            .font(.callout)
                            .foregroundStyle(store.activeTab == tab ? (scheme == .dark ? .black : .white) : Color.primary)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 15)
                            .background {
                                if store.activeTab == tab {
                                    Capsule()
                                        .fill(Color.primary)
                                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                } else {
                                    Capsule()
                                        .fill(.background)
                                }
                            }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

// MARK: - Currency View
extension ConversionView {
    @ViewBuilder
    private func currencyView() -> some View {
        ForEach(store.sortedCurrencies) { currency in
            CurrencyView(currency: currency, isShimmering: store.isShimmering)
        }
    }
}
