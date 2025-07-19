//
//  LocationsWireframe.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import UIKit

protocol LocationsWireframeProtocol {
    func onLocationsList()
    func onLocation(_ location: LocationModel)
    func onServerSelection()
}

struct LocationsWireframe: LocationsWireframeProtocol {
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func onLocationsList() {
        let wireFrame = LocationsWireframe(navigationController)
        let presenter = LocationsListPresenter(wireframe: wireFrame)
        let locationsListViewController = LocationsListViewController(presenter)
        
        navigationController.setViewControllers([locationsListViewController], animated: true)
    }
    
    func onLocation(_ location: LocationModel) {
        
    }
    
    func onServerSelection() {
        
    }
}
