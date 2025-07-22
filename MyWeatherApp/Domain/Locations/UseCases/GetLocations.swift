//
//  GetLocations.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import Foundation

protocol GetLocationsUseCaseProtocol {
    func getLocations() async -> [LocationModel]
    func save(_ location: LocationModel) async
    func delete(_ location: LocationModel) async
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
    
    func getLocations() async -> [LocationModel] {
        await repository.getLocations()
    }
    
    func save(_ location: LocationModel) async {
        await repository.save(location)
    }
    
    func delete(_ location: LocationModel) async {
        await repository.delete(location)
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
