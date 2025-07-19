import Foundation

protocol OpenWeatherDataSourceProtocol {
    func getCurrentWeather(lat: Double, lon: Double) async throws -> OpenWeatherDTO
    func getForecast() async throws -> [OpenWeatherDTO]
}

final class OpenWeatherDataSource: OpenWeatherDataSourceProtocol {
    private let apiClient: APIClientProtocol
    private let decoder: JSONDecoderProtocol
    
    init(apiClient: APIClientProtocol = APIClient(), decoder: JSONDecoderProtocol = JSONDecoder()) {
        self.apiClient = apiClient
        self.decoder = decoder
    }
    
    func getCurrentWeather(lat: Double, lon: Double) async throws -> OpenWeatherDTO {
        let apiKey = AppSettings.shared.currentWeatherService.apiKey
        let parameters: [String: Any] = ["lat": lat, "lon": lon, "units": "metric", "appid": apiKey]
        let endpoint = OpenWeatherCurrentConditionEndpoint(parameters)
        let data = try await apiClient.perorrmRequest(with: endpoint)
        let dto = try decoder.decode(OpenWeatherDTO.self, from: data)
        return dto
    }
    
    func getForecast() async throws -> [OpenWeatherDTO] {
        []
    }
}

