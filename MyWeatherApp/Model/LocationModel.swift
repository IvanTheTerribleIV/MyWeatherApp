//
//  LocationModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import MapKit

final class LocationModel {
    let name: String
    let latitude: Double
    let longitude: Double
    
    var currentWeather: CurrentWeatherModel!
    var forecast: [ForecastModel]
    
    init(name: String, latitude: Double, longitude: Double, currentWeather: CurrentWeatherModel? = nil, forecast: [ForecastModel] = []) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.currentWeather = currentWeather
        self.forecast = forecast
    }
}

extension LocationModel {
    convenience init?(placeMark: MKPlacemark) {
        guard let name = placeMark.title, let location = placeMark.location else { return nil }

        self.init(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}
