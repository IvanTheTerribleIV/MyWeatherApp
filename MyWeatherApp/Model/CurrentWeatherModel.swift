//
//  CurrentWeatherModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import Foundation

struct CurrentWeatherModel {
    let condition: String
    let description: String
    let icon: String
    
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    
    let sunrise: Double?
    let sunset: Double?
    
    let date: Date
}

extension CurrentWeatherModel {
    init(openWeatherDTO: OpenWeatherDTO) throws {
        guard let mainInfo = openWeatherDTO.weather.first else {
            throw DecodingError.valueNotFound(OpenWeatherDTO.self, .init(codingPath: [], debugDescription: "openWeatherDTO.weather.first"))
        }

        self.init(condition: mainInfo.main,
                  description: mainInfo.description,
                  icon: mainInfo.icon,
                  temp: openWeatherDTO.main.temp,
                  feelsLike: openWeatherDTO.main.feelsLike,
                  tempMin: openWeatherDTO.main.tempMin,
                  tempMax: openWeatherDTO.main.tempMax,
                  pressure: openWeatherDTO.main.pressure,
                  humidity: openWeatherDTO.main.humidity,
                  sunrise: openWeatherDTO.sys.sunrise,
                  sunset: openWeatherDTO.sys.sunset,
                  date: Date(timeIntervalSince1970: openWeatherDTO.date))
    }
}

extension CurrentWeatherModel {
    static var stub: CurrentWeatherModel {
        .init(condition: "", description: "", icon: "", temp: 0, feelsLike: 0, tempMin: 0, tempMax: 0, pressure: 0, humidity: 0, sunrise: nil, sunset: nil, date: Date())
    }
}
