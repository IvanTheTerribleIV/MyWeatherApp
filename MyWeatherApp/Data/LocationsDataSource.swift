//
//  LocationsDataSource.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import MapKit

protocol LocationsDataSourceProtocol {
    func getLocations(by name: String) async throws -> [MKMapItem]
    func searchLocation(searchText: String, completionHandler: @escaping ((Result<[MKLocalSearchCompletion], Error>) -> Void))
}

final class LocationsDataSource: NSObject, LocationsDataSourceProtocol {
    private let completer = MKLocalSearchCompleter()
    private var completionHandler: ((Result<[MKLocalSearchCompletion], Error>) -> Void)?
    
    init(geocoder: GeoCoderProtocol = CLGeocoder()) {
        super.init()
        completer.delegate = self
        completer.resultTypes = [.address, .pointOfInterest]
    }
    
    func getLocations(by name: String) async throws -> [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = name
        
        let search = MKLocalSearch(request: request)
        let response = try await search.start()
        return response.mapItems
    }
    
    func searchLocation(searchText: String, completionHandler: @escaping ((Result<[MKLocalSearchCompletion], Error>) -> Void)) {
        self.completionHandler = completionHandler
        DispatchQueue.main.async {
            self.completer.queryFragment = searchText
        }
    }
}

extension LocationsDataSource: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completionHandler?(.success(completer.results))
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        completionHandler?(.failure(error))
    }
}
