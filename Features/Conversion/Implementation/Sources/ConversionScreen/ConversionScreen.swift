//
//  ConversionScreen.swift
//  Conversion
//
//  Created by Siarhei Runovich on 3.06.24.
//

import SwiftData
import SwiftUI

public struct ConversionScreen: View {
    @State var searchText = ""
    @State var activeTab: SortingTab = .defaultSort
    @FocusState private var isSearching: Bool
    @Environment(\.colorScheme) var scheme
    @Namespace private var animation

    @State var viewModel = ConversionScreenViewModel()
    @Environment(\.modelContext) var modelContext

    public init() {}

    public var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                dummyMessagesView()
            }
            .safeAreaPadding(15)
            .safeAreaInset(edge: .top, spacing: 0) {
                expandableBavigationBar()
            }
            .animation(.snappy(duration: 0.3, extraBounce: 0), value: isSearching)
        }
        .scrollTargetBehavior(CustomScrolltargetBehaviour())
        .background(.gray.opacity(0.15))
        .contentMargins(.top, 190, for: .scrollIndicators)
        .onAppear {
            viewModel.getCurrencyData()
        }
    }
}

extension ConversionScreen {
    /// Expandable Navigation Bar
    @ViewBuilder
    func expandableBavigationBar() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
            let scrollViewHeight = proxy.bounds(of: .scrollView(axis: .vertical))?.height ?? 0
            let scaleProgress = minY > 0 ? 1 + (max(min(minY / scrollViewHeight, 1), 0) * 0.5) : 1
            let progress = isSearching ? 1 : max(min(-minY / 70, 1), 0)

            VStack(spacing: 10) {
                // Title
                Text("\(CurrencyCountryType.unitedStatesDollar.fullName)")
                    .font(.largeTitle.bold())
                    .scaleEffect(scaleProgress, anchor: .topLeading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)

                // Search Bar
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                    TextField("Search Countries", text: $searchText)
                        .focused($isSearching)

                    if isSearching {
                        Button(action: {
                            isSearching = false
                            searchText = ""
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
                .frame(height: 45)
                .clipShape(.capsule)
                .background {
                    RoundedRectangle(cornerRadius: 25 - (progress * 25))
                        .fill(.background)
                        .shadow(color: .gray.opacity(0.25), radius: 5, x: 0, y: 5)
                        .padding(.top, -progress * 190)
                        .padding(.bottom, -progress * 65)
                        .padding(.horizontal, -progress * 15)
                }

                // Custom Segmented Picker
                ScrollView(.horizontal) {
                    HStack(spacing: 12) {
                        ForEach(SortingTab.allCases, id: \.rawValue) { tab in
                            Button(action: {
                                withAnimation(.snappy) {
                                    activeTab = tab
                                }
                            }) {
                                Text(tab.rawValue)
                                    .font(.callout)
                                    .foregroundStyle(activeTab == tab ? (scheme == .dark ? .black : .white) : Color.primary)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .background {
                                        if activeTab == tab {
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
            .padding(.top, 25)
            .safeAreaPadding(.horizontal, 15)
            .offset(y: minY < 0 || isSearching ? -minY : 0)
            .offset(y: -progress * 65)
        }
        .frame(height: 190)
        .padding(.bottom, 10)
        .padding(.bottom, isSearching ? -65 : 0)
    }

    /// Dummy Messages View
    @ViewBuilder
    func dummyMessagesView() -> some View {
        ForEach(sortedCurrencies()) { currency in
            CurrencyCell(currency: currency)
        }
    }

    func sortedCurrencies() -> [Currency] {
        var filtered = viewModel.currency

        if !searchText.isEmpty {
            filtered = filtered.filter {
                $0.fullName.localizedCaseInsensitiveContains(searchText) ||
                $0.code.localizedCaseInsensitiveContains(searchText)
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
}

#Preview {
    ConversionScreen()
}
