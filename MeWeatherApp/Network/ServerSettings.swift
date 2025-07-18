//
//  ServerSettings.swift
//  MeWeatherApp
//
//  Created by Ivan Makarov on 18.07.2025.
//

protocol ServerSettingsType {
    var name: String { get }
    var baseUrl: String { get }
    var apiKey: String { get }
}
