//
//  SearchOptionViewModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import Foundation

final class SearchOptionViewModel: Identifiable, ObservableObject {
    let id: String = UUID().uuidString
    private let model: SearchOptionModel
    
    @Published
    var isLoading: Bool = false

    var title: String {
        model.title
    }
    
    var subtitle: String {
        model.subtitle
    }
    
    init(model: SearchOptionModel) {
        self.model = model
    }
}
