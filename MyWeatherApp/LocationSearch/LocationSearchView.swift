//
//  LocationSearchView.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import SwiftUI

struct LocationSearchView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject
    private var viewModel: LocationSearchViewModel
    
    init(_ viewModel: LocationSearchViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            contentView
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    }
                }
            }
            .navigationTitle("Location search")
            .searchable(text: $viewModel.searchText, prompt: Text("Enter location name"))
        }
        .disabled(viewModel.isLoading)
        .onDisappear {
            viewModel.task?.cancel()
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.locationsOptions.isEmpty {
            emptyView
        } else {
            listView
        }
    }
    
    private var listView: some View {
        List {
            ForEach(viewModel.locationsOptions) { option in
                SearchOptionView(viewModel: option) {
                    viewModel.select(option)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    dismiss()
                }) {
                    Text("Cancel")
                }
            }
        }
    }
    
    private var emptyView: some View {
        VStack {
            Spacer()
            Image(systemName: "location.magnifyingglass")
                .font(.system(size: 80))
            Text("No locations found")
            Spacer()
        }
    }
}
