//
//  GetLocations.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import Foundation

protocol GetLocationsUseCaseProtocol {
    func getLocations() -> [LocationModel]
    func getLocations(by name: String) async throws -> LocationModel
    func searchLocation(searchText: String, completion: @escaping (Result<[SearchOptionModel], Error>) -> Void)
}

struct GetLocations: GetLocationsUseCaseProtocol {
    enum LocatiionError: Error {
        case notFound
    }
    private let repository: LocationsRepositoryProtocol
    
    init(repository: LocationsRepositoryProtocol = LocationsRepository()) {
        self.repository = repository
    }
    
    func getLocations() -> [LocationModel] {
        repository.getLocations()
    }
    
    func getLocations(by name: String) async throws -> LocationModel {
        let locations = try await repository.getLocations(by: name)
        guard let location = locations.first else { throw LocatiionError.notFound }
        return location
    }
    
    func searchLocation(searchText: String, completion: @escaping (Result<[SearchOptionModel], Error>) -> Void) {
        repository.searchLocation(searchText: searchText, completion: completion)
    }
}
