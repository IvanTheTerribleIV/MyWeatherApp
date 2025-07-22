//
//  LocationsListPresenter.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import UIKit

protocol LocationsListRowPresenterProtocol {
    var ui: LocationRowUI? { get set }
    var getDataTask: Task<Void, Never>? { get }
    var name: String { get }
    var icon: UIImage? { get }
    var currentTemperature: String { get }
    var conditions: String { get }
    var minMaxTempTitle: String { get }
    func deleteData()
    func getWeatherData()
}

final class LocationsListRowPresenter: LocationsListRowPresenterProtocol {
    weak var ui: LocationRowUI?
    private let model: LocationModel
    private let weatherSseCase: GetWeatherUseCaseProtocol
    private let locationUseCase: GetLocationsUseCaseProtocol
    private(set) var getDataTask: Task<Void, Never>?
    
    var name: String {
        model.name
    }
    
    init(model: LocationModel, weatherSseCase: GetWeatherUseCaseProtocol, locationUseCase: GetLocationsUseCaseProtocol) {
        self.model = model
        self.weatherSseCase = weatherSseCase
        self.locationUseCase = locationUseCase
    }
    
    var currentTemperature: String {
        guard let currentWeather = model.currentWeather else { return "" }
        let measurement = Measurement(value: currentWeather.temp, unit: UnitTemperature.celsius)
        return MeasurementFormatter.temperatureFormatter.string(from: measurement)
    }
    
    var conditions: String {
        guard let currentWeather = model.currentWeather else { return "" }
        return currentWeather.condition
    }
    
    var minMaxTempTitle: String {
        guard let currentWeather = model.currentWeather else { return "" }
        let minTemp = Measurement(value: currentWeather.tempMin, unit: UnitTemperature.celsius)
        let maxTemp = Measurement(value: currentWeather.tempMax, unit: UnitTemperature.celsius)
        let minTempString = MeasurementFormatter.temperatureFormatter.string(from: minTemp)
        let maxTempString = MeasurementFormatter.temperatureFormatter.string(from: maxTemp)
        return "H:\(maxTempString) L:\(minTempString)"
    }
    
    var icon: UIImage?
    
    func getWeatherData() {
        getDataTask = Task {
            do {
                model.currentWeather = try await weatherSseCase.getCurrentWeather(for: model)
                icon = await getIcon()

                await MainActor.run {
                    ui?.reload()
                }
            } catch {
                await MainActor.run {
                    ui?.showErroState(presenter: self)
                }
            }
        }
    }
    
    func deleteData() {
        Task { await locationUseCase.delete(model) }
    }
    
    private func getIcon() async -> UIImage? {
        guard let currentWeather = model.currentWeather else { return nil }
        let iconUrl = AppSettings.shared.currentWeatherService.iconUrl
        let formattedUrl = String(format: iconUrl, currentWeather.icon)
        guard let url = URL(string: formattedUrl) else { return nil }
        return await weatherSseCase.getIcon(from: url)
    }
}
