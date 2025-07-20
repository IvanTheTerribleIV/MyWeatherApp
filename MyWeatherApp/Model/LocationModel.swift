//
//  LocationModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import MapKit

struct LocationModel {
    let name: String
    let latitude: Double
    let longitude: Double
}

extension LocationModel {
    init?(placeMark: MKPlacemark) {
        guard let name = placeMark.title, let location = placeMark.location else { return nil }

        self.init(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
}
