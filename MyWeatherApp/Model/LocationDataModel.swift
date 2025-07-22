//
//  LocationModel 2.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 22.07.2025.
//
import Foundation
import SwiftData

@Model
final class LocationDataModel {
    @Attribute(.unique) var id: String
    var name: String
    var latitude: Double
    var longitude: Double

    init(id: String = UUID().uuidString, name: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
}
