//
//  ForecastContentViewModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import SwiftUI

final class ForecastContentViewModel: ObservableObject {
    private let model: [ForecastModel]
    
    var viewModels: [ForecasetListRowViewModel] {
        model.map { .init(model: $0) }
    }
    
    
    init(_ model: [ForecastModel]) {
        self.model = model
    }
    
}
