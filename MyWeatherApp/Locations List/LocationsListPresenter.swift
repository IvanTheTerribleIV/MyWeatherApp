import Foundation

protocol LocationsListPresenterProtocol: AnyObject {
    var ui: LocationsListUI? { get set }
    func screenTitle() -> String
    func getLocations()
    
    func selectLocation(at indexPath: IndexPath) 
}

protocol LocationsListUI: AnyObject {
    func update(locations: [LocationsListRowPresenterProtocol])
}

final class LocationsListPresenter: LocationsListPresenterProtocol {
    weak var ui: LocationsListUI?
    private let getLocationsUseCase: GetLocationsUseCaseProtocol
    private let wireframe: LocationsWireframeProtocol
    private var locations: [LocationModel]
    
    init(locations: [LocationModel] = [], getLocationsUseCase: GetLocationsUseCaseProtocol = GetLocations(), wireframe: LocationsWireframeProtocol) {
        self.locations = locations
        self.getLocationsUseCase = getLocationsUseCase
        self.wireframe = wireframe
    }
    
    func screenTitle() -> String {
        "List of Locations"
    }
    
    // MARK: UseCases
    func getLocations() {
        locations = getLocationsUseCase.execute()
        let useCase = GetWeatherUseCase()
        let presenters: [LocationsListRowPresenter] = locations.map { .init(model: $0, useCase: useCase) }
        
        ui?.update(locations: presenters)
    }
    
    func selectLocation(at indexPath: IndexPath) {
        let location = locations[indexPath.row]
        wireframe.onLocation(location)
    }
    
    func cancelAllTasks() {
        
    }
}
