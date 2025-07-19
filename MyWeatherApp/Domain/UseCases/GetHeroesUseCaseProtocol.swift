//
//  GetHeroesUseCaseProtocol.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//


import Foundation

protocol GetHeroesUseCaseProtocol {
    func execute(completionBlock: @escaping (CharacterDataContainer) -> Void)
}

struct GetHeroes: GetHeroesUseCaseProtocol {
    private let repository: MarvelRepositoryProtocol
    
    init(repository: MarvelRepositoryProtocol = MarvelRepository()) {
        self.repository = repository
    }
    
    func execute(completionBlock: @escaping (CharacterDataContainer) -> Void) {
        // switch between repos and provide model of view depending on settings
        repository.getHeroes(completionBlock: completionBlock)
    }
}
