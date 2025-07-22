import UIKit
import Foundation

protocol OpenWeatherRepositoryProtocol {
    func getCurrentWeather(lat: Double, lon: Double) async throws -> CurrentWeatherModel
    func getForecast(lat: Double, lon: Double) async throws -> [CurrentWeatherModel]
    func getIcon(from url: URL) async -> UIImage?
}

struct OpenWeatherRepository: OpenWeatherRepositoryProtocol {
    private let dataSource: OpenWeatherDataSourceProtocol
    
    init(dataSource: OpenWeatherDataSourceProtocol = OpenWeatherDataSource()) {
        self.dataSource = dataSource
    }
    
    func getCurrentWeather(lat: Double, lon: Double) async throws -> CurrentWeatherModel {
        let dto = try await dataSource.getCurrentWeather(lat: lat, lon: lon)
        let model = try CurrentWeatherModel(openWeatherDTO: dto)
        return model
    }
    
    func getForecast(lat: Double, lon: Double) async throws -> [CurrentWeatherModel] {
        let dto = try await dataSource.getForecast(lat: lat, lon: lon)
        let model = try dto.map { try CurrentWeatherModel(openWeatherDTO: $0) }
        return model
    }
    
    func getIcon(from url: URL) async -> UIImage? {
        guard let data = await dataSource.getIconData(from: url) else { return nil }
        let image = UIImage(data: data)
        return image
    }
}
