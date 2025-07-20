//
//  GeoCoderProtocol.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import CoreLocation

protocol GeoCoderProtocol {
    func geocodeAddressString(_ addressString: String) async throws -> [CLPlacemark]
}

extension CLGeocoder: GeoCoderProtocol {}
