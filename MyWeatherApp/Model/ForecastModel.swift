//
//  ForecastModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import Foundation

final class ForecastModel {
    let date: Date
    var weather: [CurrentWeatherModel]
    
    init(date: Date, weather: [CurrentWeatherModel]) {
        self.date = date
        self.weather = weather
    }
}
