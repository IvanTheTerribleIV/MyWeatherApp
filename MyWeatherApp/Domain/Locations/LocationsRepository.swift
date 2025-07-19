//
//  LocationsRepository.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

protocol LocationsRepositoryProtocol {
    func getLocations() -> [LocationModel]
}

struct LocationsRepository: LocationsRepositoryProtocol {
    func getLocations() -> [LocationModel] {
        [.init(name: "Barcelona", latitude: 41.415518, longitude: 2.194770)]
    }
}
