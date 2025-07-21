//
//  LocationForecastView.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import SwiftUI

struct LocationForecastView: View {
    private let viewModel: LocationForecastViewModel
    
    init(_ viewModel: LocationForecastViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.addLocation()
                    }) {
                        Text("Done")
                    }
                }
            }
    }
    
    @ViewBuilder
    private var content: some View {
        ScrollView {
            CurrentWeatherView(viewModel.currentWeatherViewModel)
                .padding()
            ForecastView(viewModel.forecastViewModel)
                .padding()
                
        }
    }
}
