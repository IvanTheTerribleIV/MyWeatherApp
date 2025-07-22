//
//  LocationsRepository.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import Foundation

protocol LocationsRepositoryProtocol {
    func getLocations() async -> [LocationModel]
    func save(_ location: LocationModel) async
    func delete(_ location: LocationModel) async
    func getLocations(by name: String) async throws -> [LocationModel]
    func searchLocation(searchText: String, completion: @escaping (Result<[SearchOptionModel], Error>) -> Void)
}

struct LocationsRepository: LocationsRepositoryProtocol {
    private let dataSource: LocationsDataSourceProtocol
    private let dataManager: DataManager<LocationDataModel> = .manager
    
    init(dataSource: LocationsDataSourceProtocol = LocationsDataSource()) {
        self.dataSource = dataSource
    }
    
    @MainActor
    func getLocations() async -> [LocationModel] {
        let dataModels = dataManager.fetchAll()
        return dataModels.compactMap { LocationModel(dataModel: $0) }
    }
    
    func save(_ location: LocationModel) async {
        let dataModel = LocationDataModel(id: location.id, name: location.name, latitude: location.latitude, longitude: location.longitude)
        await dataManager.insert(dataModel)
    }
    
    @MainActor
    func delete(_ location: LocationModel) async  {
        let id = location.id
        let predicate = #Predicate<LocationDataModel> { $0.id == id }
            
        guard let modelToDelete = dataManager.fetchFirst(where: predicate) else { return }
        dataManager.delete(modelToDelete)
    }
    
    func getLocations(by name: String) async throws -> [LocationModel] {
        let dto = try await dataSource.getLocations(by: name)
        return dto.compactMap { LocationModel(placeMark: $0.placemark) }
    }
    
    func searchLocation(searchText: String, completion: @escaping (Result<[SearchOptionModel], Error>) -> Void) {
        dataSource.searchLocation(searchText: searchText) { result in
            switch result {
            case .success(let options):
                completion(.success(options.map { SearchOptionModel(with: $0) }))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
