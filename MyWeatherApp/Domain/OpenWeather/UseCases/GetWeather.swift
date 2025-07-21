//
//  GetWeather.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import Foundation

protocol GetWeatherUseCaseProtocol {
    func getCurrentWeather(for location: LocationModel) async throws -> CurrentWeatherModel
    func getForecast(for location: LocationModel) async throws -> [ForecastModel]
}

struct GetWeatherUseCase: GetWeatherUseCaseProtocol {
    private let repository: OpenWeatherRepositoryProtocol
    
    init(repository: OpenWeatherRepositoryProtocol = OpenWeatherRepository()) {
        self.repository = repository
    }
    
    func getCurrentWeather(for location: LocationModel) async throws -> CurrentWeatherModel {
        try await repository.getCurrentWeather(lat: location.latitude, lon: location.longitude)
    }
    
    func getForecast(for location: LocationModel) async throws -> [ForecastModel] {
        let weather = try await repository.getForecast(lat: location.latitude, lon: location.longitude)
        var forecastArray: [ForecastModel] = []
        
        var set: Set<String> = []
        
        weather.forEach { weatherModel in
            let date = DateFormatter.shortDateForematter.string(from: weatherModel.date)
            if set.contains(date) {
                forecastArray.last?.weather.append(weatherModel)
            } else {
                let forecastModel = ForecastModel(date: weatherModel.date, weather: [weatherModel])
                forecastArray.append(forecastModel)
                set.insert(date)
            }
        }
        return forecastArray
    }
}
