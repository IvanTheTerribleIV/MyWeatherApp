//
//  OpenWeatherCurrentConditionEndpoint.swift
//  MeWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//


struct OpenWeatherCurrentConditionEndpoint: RestEndpoint {
    let path: String = "data/2.5/weather"
    let method: HTTPMethod = .get
    
    let parameters: [String : Any]
    
    init(_ parameters: [String: Any]) {
        self.parameters = parameters
    }
}
