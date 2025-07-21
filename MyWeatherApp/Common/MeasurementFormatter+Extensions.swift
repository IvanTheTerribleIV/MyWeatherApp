//
//  ErrorViewModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import Foundation

extension MeasurementFormatter {
    static let temperatureFormatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        return formatter
    }()
}

