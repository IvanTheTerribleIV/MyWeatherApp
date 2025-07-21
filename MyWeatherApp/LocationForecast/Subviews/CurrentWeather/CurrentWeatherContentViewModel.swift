//
//  CurrentWeatherContentViewModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import Foundation

struct CurrentWeatherContentViewModel: Identifiable {
    private let model: CurrentWeatherModel
    private let location: LocationModel
    
    init(_ model: CurrentWeatherModel, location: LocationModel) {
        self.model = model
        self.location = location
    }
    
    let id: String = UUID().uuidString

    var locationName: String {
        location.name
    }
    
    var time: String {
        DateFormatter.hoursDateForematter.string(from: model.date)
    }
        
    var currentTemp: String {
        let measurement = Measurement(value: model.temp, unit: UnitTemperature.celsius)
        return MeasurementFormatter.temperatureFormatter.string(from: measurement)
    }
    
    var conditions: String {
        model.condition
    }
    
    var minMaxTemp: String {
        let minTemp = Measurement(value: model.tempMin, unit: UnitTemperature.celsius)
        let maxTemp = Measurement(value: model.tempMax, unit: UnitTemperature.celsius)
        let minTempString = MeasurementFormatter.temperatureFormatter.string(from: minTemp)
        let maxTempString = MeasurementFormatter.temperatureFormatter.string(from: maxTemp)
        return "H:\(maxTempString) L:\(minTempString)"
    }
    
    var iconUrl: URL? {
        let iconUrl = AppSettings.shared.currentWeatherService.iconUrl
        let formattedUrl = String(format: iconUrl, model.icon)
        return URL(string: formattedUrl)
    }
}
