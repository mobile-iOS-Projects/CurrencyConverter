//
//  RecentsView.swift
//  CurrencyConverter
//
//  Created by Sergey Runovich on 11.04.24.
//

import SwiftUI

struct RecentsView: View {
    // MARK: - Coordinator
    @Bindable var coordinator: RecentsCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                ZStack {
                    Rectangle().fill(Color.yellow)
                    Text("Tap on me")
                        .onTapGesture {
                            coordinator.openScreen(screen: .main)
                        }
                }
            }.navigationDestination(for: RecentsScreenType.self) { page in
                coordinator.getView(screen: page)
            }
        }
    }
}

#Preview {
    RecentsView(coordinator: .init(appRootCoordinator: .init()))
}
