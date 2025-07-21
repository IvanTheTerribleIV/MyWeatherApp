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
    private let completion: (LocationModel?) -> Void
    private(set) var task: Task<Void, Never>?
    
    deinit {
        print("deinit")
    }
    
    @Published
    var locationsOptions: [SearchOptionViewModel] = []
    
    @Published
    var searchText: String = ""
    
    @Published
    var isLoading: Bool = false
    
    
    
    init(useCase: GetLocationsUseCaseProtocol = GetLocations(), wireframe: LocationsWireframeProtocol, completion: @escaping (LocationModel?) -> Void) {
        self.useCase = useCase
        self.wireframe = wireframe
        self.completion = completion
        
        $searchText.sink { [weak self] text in
            self?.useCase.searchLocation(searchText: text) { result in
                switch result {
                case .success(let options):
                    guard let self else { return }

                    let selectionViewModels = options.map {
                        let selectionViewModel = SearchOptionViewModel(model: $0)
                        selectionViewModel.$isLoading.sink { [weak self] isLoading in
                            self?.isLoading = isLoading
                        }
                        .store(in: &self.cancellables)
                        return selectionViewModel
                    }
                    self.updateList(options: selectionViewModels)
                case .failure:
                    self?.updateList(options: [])
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
                wireframe.onLocationDetails(location, completion: completion)
            } catch {
                option.isLoading = false
                let errorViewModel = ErrorViewModel(title: "Error", subtitle: "The location not found, try another option", action: {})
                wireframe.showErrorAlert(with: errorViewModel)
            }
        }
    }
    
    func onCancel() {
        completion(nil)
    }
}
