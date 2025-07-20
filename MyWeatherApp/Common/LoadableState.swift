//
//  LoadableState.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

enum LoadableState<T> {
    case loading
    case error(ErrorViewModel)
    case content(T)
}
