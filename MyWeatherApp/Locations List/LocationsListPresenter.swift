import Foundation

protocol LocationsListPresenterProtocol: AnyObject {
//    var locationsListProvider: LocationsListAdapter { get }
    var ui: LocationsListUI? { get set }
    func screenTitle() -> String
    func getLocations()
}

protocol LocationsListUI: AnyObject {
    func update(locations: [LocationModel])
}

final class LocationsListPresenter: LocationsListPresenterProtocol {
    weak var ui: LocationsListUI?
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
        ui?.update(locations: locations)
    }
}

