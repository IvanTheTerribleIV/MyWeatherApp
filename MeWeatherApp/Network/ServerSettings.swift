//
//  ServerSettings.swift
//  MeWeatherApp
//
//  Created by Ivan Makarov on 18.07.2025.
//

protocol ServerSettingsType {
    var name: String { get }
    var baseUrl: String { get }
    var apiKey: String { get }
}

struct OpenWeatherServerSettings: ServerSettingsType {
    let name: String = "Open weather"
    let baseUrl: String = "https://api.openweathermap.org"
    let apiKey: String = "b717d41ff1cac419376fbfa16005204e"
}



final class AppSettings {
    var currentWeatherService: ServerSettingsType
    
    init(currentWeatherService: ServerSettingsType = OpenWeatherServerSettings()) {
        self.currentWeatherService = currentWeatherService
    }
}
