import Foundation

protocol LocationsListPresenterProtocol: AnyObject {
    var ui: LocationsListUI? { get set }
    func screenTitle() -> String
    func getLocations()
}

protocol LocationsListUI: AnyObject {
    func update(locations: [LocationModel])
}

final class LocationsListPresenter: LocationsListPresenterProtocol {
    var ui: LocationsListUI?
    private let getLocationsUseCase: GetLocationsUseCaseProtocol
    
    init(getLocationsUseCase: GetLocationsUseCaseProtocol = GetLocations()) {
        self.getLocationsUseCase = getLocationsUseCase
    }
    
    func screenTitle() -> String {
        "List of Locations"
    }
    
    // MARK: UseCases
    
    func getLocations() {
        let locations = getLocationsUseCase.execute()
        print("Characters \(locations)")
        self.ui?.update(locations: locations)
    }
}

