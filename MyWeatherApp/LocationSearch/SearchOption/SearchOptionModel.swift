//
//  SearchOptionModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import MapKit

struct SearchOptionModel {
    let title: String
    let subtitle: String
}

extension SearchOptionModel {
    init(with dto: MKLocalSearchCompletion) {
        self.init(title: dto.title, subtitle: dto.subtitle)
    }
}
