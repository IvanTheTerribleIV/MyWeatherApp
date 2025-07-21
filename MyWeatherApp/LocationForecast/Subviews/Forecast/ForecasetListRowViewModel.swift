//
//  ForecasetListRowViewModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import Foundation

struct ForecasetListRowViewModel: Identifiable {
    let id: String = UUID().uuidString
    
    private let model: ForecastModel
    
    init(model: ForecastModel) {
        self.model = model
    }
    
    var dayViewModels: [CurrentWeatherContentViewModel] {
        model.weather.map { .init($0, location: .init(name: "", latitude: 0, longitude: 0)) }
    }
    
    var weekDay: String {
        DateFormatter.weekDayDateFormatter.string(from: model.date)
    }
    
//    var minMaxTemp: String {
//        let minTemp = Measurement(value: model.tempMin, unit: UnitTemperature.celsius)
//        let maxTemp = Measurement(value: model.tempMax, unit: UnitTemperature.celsius)
//        let minTempString = MeasurementFormatter.temperatureFormatter.string(from: minTemp)
//        let maxTempString = MeasurementFormatter.temperatureFormatter.string(from: maxTemp)
//        return "H:\(maxTempString) L:\(minTempString)"
//    }
//    
//    var iconUrl: URL? {
//        let iconUrl = AppSettings.shared.currentWeatherService.iconUrl
//        let formattedUrl = String(format: iconUrl, model.icon)
//        return URL(string: formattedUrl)
//    }
    
}
