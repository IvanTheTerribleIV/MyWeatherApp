//
//  OpenWeatherForecastEndpoint.swift
//  MeWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

struct OpenWeatherForecastEndpoint: RestEndpoint {
    let path: String = "data/2.5/forecast"
    let method: HTTPMethod = .get
    let parameters: [String : Any]
    
    init(_ parameters: [String: Any]) {
        self.parameters = parameters
    }
}
