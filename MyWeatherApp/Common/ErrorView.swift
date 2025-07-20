//
//  ErrorView.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import SwiftUI

struct ErrorView: View {
    private let viewModel: ErrorViewModel
    
    init(_ viewModel: ErrorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.title)
            Text(viewModel.subtitle)
            Spacer()
            Button(action: viewModel.action) {
                Text("Try again")
            }
        }
    }
}
