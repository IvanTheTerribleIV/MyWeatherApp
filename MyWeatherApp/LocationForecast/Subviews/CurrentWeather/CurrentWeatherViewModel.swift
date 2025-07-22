//
//  CurrentWeatherViewModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import Foundation
import SwiftUI

final class CurrentWeatherViewModel: ObservableObject {
    @Published
    private(set) var state: LoadableState<CurrentWeatherContentViewModel> = .loading
    private let model: LocationModel
    private let useCase: GetWeatherUseCaseProtocol
    
    private(set) var task: Task<Void, Never>?
    
    init(model: LocationModel, useCase: GetWeatherUseCaseProtocol, state: LoadableState<CurrentWeatherContentViewModel> = .loading) {
        self.model = model
        self.useCase = useCase
        self.state = state
    }
    
    @MainActor
    func fetchData() async {
        state = .loading
        do {
            let currentWeatherModel = try await useCase.getCurrentWeather(for: model)
            model.currentWeather = currentWeatherModel
            withAnimation {
                state = .content(.init(currentWeatherModel, location: model))
            }
        } catch {
            let errorViewModel = ErrorViewModel(title: "", subtitle: "") { [weak self] in
                self?.task = Task {
                    await self?.fetchData()
                }
            }
            withAnimation {
                state = .error(errorViewModel)
            }
        }
    }
}
