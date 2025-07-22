//
//  ForecastViewModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import Foundation
import SwiftUI

final class ForecastViewModel: ObservableObject {
    @Published
    private(set) var state: LoadableState<ForecastContentViewModel> = .loading
    private let model: LocationModel
    private let useCase: GetWeatherUseCaseProtocol
    
    private(set) var task: Task<Void, Never>?
    
    init(model: LocationModel, useCase: GetWeatherUseCaseProtocol, state: LoadableState<ForecastContentViewModel> = .loading) {
        self.model = model
        self.useCase = useCase
        self.state = state
    }
    
    @MainActor
    func fetchData() async {
        state = .loading
        do {
            let forecast = try await useCase.getForecast(for: model)
            model.forecast = forecast
            withAnimation {
                state = .content(.init(forecast))
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
