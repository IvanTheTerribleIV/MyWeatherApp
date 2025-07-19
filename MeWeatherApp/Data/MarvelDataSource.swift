import Foundation

protocol MarvelDataSourceProtocol {
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void)
}

final class MarvelDataSource: MarvelDataSourceProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func getHeroes(completionBlock: @escaping (CharacterDataContainer) -> Void) {
        // decoding data to dto
        return apiClient.getHeroes(completionBlock: completionBlock)
    }
}
