//
//  GetLocations.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//


import Foundation

protocol GetLocationsUseCaseProtocol {
    func execute() -> [LocationModel]
}

struct GetLocations: GetLocationsUseCaseProtocol {
    private let repository: LocationsRepositoryProtocol
    
    init(repository: LocationsRepositoryProtocol = LocationsRepository()) {
        self.repository = repository
    }
    
    func execute() -> [LocationModel] {
        repository.getLocations()
    }
}
