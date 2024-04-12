//
//  AuthenticationView.swift
//  CurrencyConverter
//
//  Created by Sergey Runovich on 11.04.24.
//

import SwiftUI

struct AuthenticationView: View {
    // MARK: - Сoordinator
    @Bindable var coordinator: AuthorizationCoordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                ZStack{
                    Rectangle().fill(Color.green)
                    Text("Tap on me")
                        .onTapGesture {
                            coordinator.goToMain()
                        }
                }
            }.ignoresSafeArea()

        }.navigationDestination(for: AuthorizationScreenType.self) { page in
            coordinator.getView(screen: page)
        }
    }
}

#Preview {
    AuthenticationView(coordinator: .init(appRootCoordinator: .init()))
}
