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
    func onLocationDetails(_ location: LocationModel, completion: ((LocationModel?) -> Void)?)
    func onServerSelection()
    func onLocationSearch(completion: @escaping (LocationModel?) -> Void)
    func showErrorAlert(with errorViewModel: ErrorViewModel)
}

struct LocationsWireframe: LocationsWireframeProtocol {
    private unowned let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func onLocationsList() {
        let wireFrame = LocationsWireframe(navigationController)
        let presenter = LocationsListPresenter(wireframe: wireFrame)
        let locationsListViewController = LocationsListViewController(presenter)
        
        navigationController.setViewControllers([locationsListViewController], animated: true)
    }
    
    func onLocationSearch(completion: @escaping (LocationModel?) -> Void) {
        let navController = UINavigationController()
        let wireFrame = LocationsWireframe(navController)
        let viewModel = LocationSearchViewModel(wireframe: wireFrame) { location in
            self.navigationController.dismiss(animated: true) {
                completion(location)
            }
        }
        let view = LocationSearchView(viewModel)
        let viewController = UIHostingController(rootView: view)
        
        navController.setViewControllers([viewController], animated: true)
        
        navigationController.present(navController, animated: true)
    }
    
    func onLocationDetails(_ location: LocationModel, completion: ((LocationModel?) -> Void)?) {
        let viewModel = LocationForecastViewModel(model: location, completion: { location in
            self.navigationController.dismiss(animated: true) {
                completion?(location)
            }
        })
        let view = LocationForecastView(viewModel)
        let viewController = UIHostingController(rootView: view)
        
        switch completion {
        case .none:
            let navController = UINavigationController(rootViewController: viewController)
            navigationController.present(navController, animated: true)
        case .some:
            navigationController.pushViewController(viewController, animated: true)
        }
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
