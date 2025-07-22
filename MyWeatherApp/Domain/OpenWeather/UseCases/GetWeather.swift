//
//  GetWeather.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import UIKit
import Foundation

protocol GetWeatherUseCaseProtocol {
    func getCurrentWeather(for location: LocationModel) async throws -> CurrentWeatherModel
    func getForecast(for location: LocationModel) async throws -> [ForecastModel]
    func getIcon(from url: URL) async -> UIImage?
}

struct GetWeatherUseCase: GetWeatherUseCaseProtocol {
    private let repository: OpenWeatherRepositoryProtocol
    private let cahce: NSCache = NSCache<NSString, UIImage>()
    
    init(repository: OpenWeatherRepositoryProtocol = OpenWeatherRepository()) {
        self.repository = repository
    }
    
    func getCurrentWeather(for location: LocationModel) async throws -> CurrentWeatherModel {
        if let weather = location.currentWeather { return weather }
        return try await repository.getCurrentWeather(lat: location.latitude, lon: location.longitude)
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
    
    func getIcon(from url: URL) async -> UIImage? {
        if let cachedImage = cahce.object(forKey: NSString(string: url.absoluteString)) {
            return cachedImage
        }
        
        if let image = await repository.getIcon(from: url) {
            cahce.setObject(image, forKey: NSString(string: url.absoluteString))
            return image
        }
        return nil
    }
}
