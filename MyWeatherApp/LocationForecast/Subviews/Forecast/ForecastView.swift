//
//  ForecastView.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import SwiftUI

struct ForecastView: View {
    @StateObject
    private var viewModel: ForecastViewModel
    
    init(_ viewModel: ForecastViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        content
            .task {
                await viewModel.fetchData()
            }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
                .progressViewStyle(.circular)
        case .error(let errorViewModel):
            EmptyView()
        case .content(let viewModel):
            ForecastContentView(viewModel)
        }
    }
}
