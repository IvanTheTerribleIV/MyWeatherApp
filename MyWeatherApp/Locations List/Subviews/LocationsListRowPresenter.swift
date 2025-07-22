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
    func getWeatherData()
}

final class LocationsListRowPresenter: LocationsListRowPresenterProtocol {
    weak var ui: LocationRowUI?
    private let model: LocationModel
    private let useCase: GetWeatherUseCaseProtocol
    private(set) var getDataTask: Task<Void, Never>?
    
    var name: String {
        model.name
    }
    
    init(model: LocationModel, useCase: GetWeatherUseCaseProtocol) {
        self.model = model
        self.useCase = useCase
    }
    
    var currentTemperature: String {
        let measurement = Measurement(value: model.currentWeather.temp, unit: UnitTemperature.celsius)
        return MeasurementFormatter.temperatureFormatter.string(from: measurement)
    }
    
    var conditions: String {
        model.currentWeather.condition
    }
    
    var minMaxTempTitle: String {
        let minTemp = Measurement(value: model.currentWeather.tempMin, unit: UnitTemperature.celsius)
        let maxTemp = Measurement(value: model.currentWeather.tempMax, unit: UnitTemperature.celsius)
        let minTempString = MeasurementFormatter.temperatureFormatter.string(from: minTemp)
        let maxTempString = MeasurementFormatter.temperatureFormatter.string(from: maxTemp)
        return "H:\(maxTempString) L:\(minTempString)"
    }
    
    var icon: UIImage?
    
    func getWeatherData() {
        getDataTask = Task {
            do {
                model.currentWeather = try await useCase.getCurrentWeather(for: model)
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
    
    private func getIcon() async -> UIImage? {
        let iconUrl = AppSettings.shared.currentWeatherService.iconUrl
        let formattedUrl = String(format: iconUrl, model.currentWeather.icon)
        guard let url = URL(string: formattedUrl) else { return nil }
        return await useCase.getIcon(from: url)
    }
}
