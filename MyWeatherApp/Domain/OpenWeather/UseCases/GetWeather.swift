//
//  GetWeather.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

protocol GetWeatherUseCaseProtocol {
    func getCurrentWeather(for location: LocationModel) async throws -> CurrentWeatherModel
    func getForecast(for location: LocationModel) async throws -> [CurrentWeatherModel]
}

struct GetWeatherUseCase: GetWeatherUseCaseProtocol {
    private let repository: OpenWeatherRepositoryProtocol
    
    init(repository: OpenWeatherRepositoryProtocol = OpenWeatherRepository()) {
        self.repository = repository
    }
    
    func getCurrentWeather(for location: LocationModel) async throws -> CurrentWeatherModel {
        try await repository.getCurrentWeather(lat: location.latitude, lon: location.longitude)
    }
    
    func getForecast(for location: LocationModel) async throws -> [CurrentWeatherModel] {
        try await repository.getForecast(lat: location.latitude, lon: location.longitude)
    }
}
