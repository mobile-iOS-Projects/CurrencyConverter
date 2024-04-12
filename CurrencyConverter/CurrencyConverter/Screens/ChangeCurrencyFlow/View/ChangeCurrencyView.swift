//
//  ChangeCurrencyView.swift
//  CurrencyConverter
//
//  Created by Sergey Runovich on 11.04.24.
//

import SwiftUI

struct ChangeCurrencyView: View {
    // MARK: - Coordinator
    @Bindable var coordinator: MainCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                ZStack{
                    Rectangle().fill(Color.cyan)
                    Text("Tap on me")
                        .onTapGesture {
                            coordinator.openScreen(screen: .main)
                        }
                }
            }.navigationDestination(for: MainScreenType.self) { page in
                coordinator.getView(screen: page)
            }
        }
    }
}

#Preview {
    ChangeCurrencyView(coordinator: .init(appRootCoordinator: .init()))
}
