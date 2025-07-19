import Foundation

protocol MarvelRepositoryProtocol {
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void)
}

final class MarvelRepository: MarvelRepositoryProtocol {
    private let dataSource: MarvelDataSourceProtocol
    
    init(dataSource: MarvelDataSourceProtocol = MarvelDataSource()) {
        self.dataSource = dataSource
    }
    
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void) {
        // dto to model of view
        dataSource.getHeroes(completionBlock: completionBlock)
    }
}
