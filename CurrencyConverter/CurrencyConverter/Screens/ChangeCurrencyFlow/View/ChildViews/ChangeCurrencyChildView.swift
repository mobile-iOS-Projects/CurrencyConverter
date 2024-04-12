//
//  ChangeCurrencyChildView.swift
//  CurrencyConverter
//
//  Created by Sergey Runovich on 11.04.24.
//

import SwiftUI

struct ChangeCurrencyChildView: View {
    @Bindable var coordinator: MainCoordinator

    var body: some View {
        Text("ChangeCurrencyChildView")
            .onTapGesture {
                coordinator.openScreen(screen: .main)
            }
    }
}

#Preview {
    ChangeCurrencyChildView(coordinator: .init(appRootCoordinator: .init()))
}
