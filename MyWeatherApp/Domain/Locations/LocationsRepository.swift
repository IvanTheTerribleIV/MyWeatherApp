//
//  LocationsRepository.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

protocol LocationsRepositoryProtocol {
    func getLocations() -> [LocationModel]
    func getLocations(by name: String) async throws -> [LocationModel]
    func searchLocation(searchText: String, completion: @escaping (Result<[SearchOptionModel], Error>) -> Void)
}

struct LocationsRepository: LocationsRepositoryProtocol {
    private let dataSource: LocationsDataSourceProtocol
    
    init(dataSource: LocationsDataSourceProtocol = LocationsDataSource()) {
        self.dataSource = dataSource
    }
    
    func getLocations() -> [LocationModel] {
        []
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
