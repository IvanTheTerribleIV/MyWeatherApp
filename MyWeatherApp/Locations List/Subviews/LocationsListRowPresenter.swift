//
//  LocationsListPresenter.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

protocol LocationsListRowPresenterProtocol {
    var ui: LocationRowUI? { get set }
    var name: String { get }
    var minmaxTempTitle: String? { get }
    func getWeatherData()
}

final class LocationsListRowPresenter: LocationsListRowPresenterProtocol {
    weak var ui: LocationRowUI?
    private let model: LocationModel
    private var weatherData: CurrentWeatherModel?
    private let useCase: GetWeatherUseCaseProtocol
    private(set) var task: Task<Void, Never>?
    
    var name: String {
        model.name
    }
    
    var minmaxTempTitle: String? {
        guard let weatherData else { return nil }
        return "H\(weatherData.tempMax) L:\(weatherData.tempMin)"
    }
    
    init(model: LocationModel, useCase: GetWeatherUseCaseProtocol) {
        self.model = model
        self.useCase = useCase
    }
    
    func getWeatherData() {
        if let weatherData { return }
        task = Task {
            do {
//                weatherData = try await useCase.execute(for: model)
                await MainActor.run {
                    ui?.reload()
                }
            } catch {
                
            }
        }
    }
}
