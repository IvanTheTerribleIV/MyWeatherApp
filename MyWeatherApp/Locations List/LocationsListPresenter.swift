import Foundation

protocol LocationsListPresenterProtocol: AnyObject {
    var ui: LocationsListUI? { get set }
    func screenTitle() -> String
    func getHeroes()
}

protocol LocationsListUI: AnyObject {
    func update(heroes: [LocationModel])
}

final class LocationsListPresenter: LocationsListPresenterProtocol {
    var ui: LocationsListUI?
    private let getHeroesUseCase: GetHeroesUseCaseProtocol
    
    init(getHeroesUseCase: GetHeroesUseCaseProtocol = GetHeroes()) {
        self.getHeroesUseCase = getHeroesUseCase
    }
    
    func screenTitle() -> String {
        "List of Heroes"
    }
    
    // MARK: UseCases
    
    func getHeroes() {
        getHeroesUseCase.execute { characterDataContainer in
            print("Characters \(characterDataContainer.characters)")
            self.ui?.update(heroes: characterDataContainer.characters)
        }
    }
}

