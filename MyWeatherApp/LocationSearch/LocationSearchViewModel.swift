//
//  LocationSearchViewModel.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import Combine
import Foundation

final class LocationSearchViewModel: ObservableObject {
    private let useCase: GetLocationsUseCaseProtocol
    private var cancellables: Set<AnyCancellable> = []
    private let wireframe: LocationsWireframeProtocol
    
    private(set) var task: Task<Void, Never>?
    @Published
    var locationsOptions: [SearchOptionViewModel] = []
    
    @Published
    var searchText: String = ""
    
    @Published
    var isLoading: Bool = false
    
    init(useCase: GetLocationsUseCaseProtocol, wireframe: LocationsWireframeProtocol) {
        self.useCase = useCase
        self.wireframe = wireframe
        
        $searchText.sink { [weak self] text in
            guard let self else { return }
            self.useCase.searchLocation(searchText: text) { result in
                switch result {
                case .success(let options):
                    let selectionViewModels = options.map {
                        let selectionViewModel = SearchOptionViewModel(model: $0)
                        selectionViewModel.$isLoading.sink { isLoading in
                            self.isLoading = isLoading
                        }
                        .store(in: &self.cancellables)
                        return selectionViewModel
                    }
                    self.updateList(options: selectionViewModels)
                case .failure:
                    self.updateList(options: [])
                }
            }
        }
        .store(in: &cancellables)
    }

    private func updateList(options: [SearchOptionViewModel]) {
        locationsOptions = options
    }
    
    @MainActor
    func select(_ option: SearchOptionViewModel) {
        option.isLoading = true
        task = Task {
            do {
                let location = try await useCase.getLocations(by: option.title)
                option.isLoading = false
                wireframe.onLocationDetails(location)
            } catch {
                option.isLoading = false
                let errorViewModel = ErrorViewModel(title: "Error", subtitle: "The location not found, try another option", action: {})
                wireframe.showErrorAlert(with: errorViewModel)
            }
        }
    }
}
