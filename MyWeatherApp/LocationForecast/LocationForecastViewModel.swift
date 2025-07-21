//
//  LocationForecastViewModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import Foundation

final class LocationForecastViewModel: ObservableObject {
    private let model: LocationModel
    private let wireframe: LocationsWireframeProtocol
    private let useCase: GetWeatherUseCaseProtocol
    
    private(set) var task: Task<Void, Never>?
    
    var currentWeatherViewModel: CurrentWeatherViewModel {
        .init(model: model, useCase: useCase)
    }
    
    var forecastViewModel: ForecastViewModel {
        .init(model: model, useCase: useCase)
    }
    
    init(model: LocationModel, useCase: GetWeatherUseCaseProtocol = GetWeatherUseCase(), wireframe: LocationsWireframeProtocol) {
        self.model = model
        self.useCase = useCase
        self.wireframe = wireframe
    }
    
    func addLocationn() {
        
    }
}
