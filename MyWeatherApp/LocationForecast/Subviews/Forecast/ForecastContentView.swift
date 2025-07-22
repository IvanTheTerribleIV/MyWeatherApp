//
//  ForecastContentView.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import SwiftUI

struct ForecastContentView: View {
    @StateObject
    private var viewModel: ForecastContentViewModel
    
    init(_ viewModel: ForecastContentViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ForEach(viewModel.viewModels) { rowViewModel in
                ForecastListRow(rowViewModel)
            }
        }
        .background(.black)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
