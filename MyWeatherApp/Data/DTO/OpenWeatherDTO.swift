//
//  OpenWeatherDTO.swift
//  MeWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

struct OpenWeatherDTO: Decodable {
    let weather: [OpenWeatherConditionDTO]
    let main: OpenWeatherMainDTO
    let sys: Sys
}

struct OpenWeatherConditionDTO: Decodable {
    let main: String
    let description: String
    let icon: String
}

struct OpenWeatherMainDTO: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

struct Sys: Decodable {
    let sunrise: Double?
    let sunset: Double?
}
