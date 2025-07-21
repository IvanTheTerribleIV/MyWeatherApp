//
//  LocationForecastViewModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import Foundation

final class LocationForecastViewModel: ObservableObject {
    private let model: LocationModel
    private let useCase: GetWeatherUseCaseProtocol
    private let completion: (LocationModel) -> Void
    private(set) var task: Task<Void, Never>?
    
    var currentWeatherViewModel: CurrentWeatherViewModel {
        .init(model: model, useCase: useCase)
    }
    
    var forecastViewModel: ForecastViewModel {
        .init(model: model, useCase: useCase)
    }
    
    init(model: LocationModel, useCase: GetWeatherUseCaseProtocol = GetWeatherUseCase(), completion: @escaping (LocationModel?) -> Void) {
        self.model = model
        self.useCase = useCase
        self.completion = completion
    }
    
    func addLocation() {
        completion(model)
    }
}
