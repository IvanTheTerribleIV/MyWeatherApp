//
//  LocationsWireframe.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import UIKit
import SwiftUI

protocol LocationsWireframeProtocol {
    func onLocationsList()
    func onLocationDetails(_ location: LocationModel)
    func onServerSelection()
    func onLocationSearch(completion: @escaping (LocationModel) -> Void)
    func showErrorAlert(with errorViewModel: ErrorViewModel)
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
    
    func onLocationSearch(completion: @escaping (LocationModel) -> Void) {
        let navController = UINavigationController()
        let wireFrame = LocationsWireframe(navController)
        let viewModel = LocationSearchViewModel(useCase: GetLocations(), wireframe: wireFrame)
        let view = LocationSearchView(viewModel)
        let viewController = UIHostingController(rootView: view)
        
        navController.setViewControllers([viewController], animated: true)
        
        navigationController.present(navController, animated: true)
    }
    
    func onLocationDetails(_ location: LocationModel) {
        let wireFrame = LocationsWireframe(navigationController)
        let viewModel = LocationForecastViewModel(model: location, wireframe: wireFrame)
        let view = LocationForecastView(viewModel)
        let viewController = UIHostingController(rootView: view)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func onServerSelection() {
        
    }
    
    func showErrorAlert(with errorViewModel: ErrorViewModel) {
        let alertController = UIAlertController(title: errorViewModel.title, message: errorViewModel.subtitle, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        navigationController.present(alertController, animated: true)
    }
}
