//
//  SearchOptionView.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import SwiftUI

struct SearchOptionView: View {
    @StateObject
    private var viewModel: SearchOptionViewModel
    private let selectionAction: () -> Void
    
    init(viewModel: SearchOptionViewModel, selectionAction: @escaping () -> Void) {
        self._viewModel = .init(wrappedValue: viewModel)
        self.selectionAction = selectionAction
    }
    
    var body: some View {
        Button(action: selectionAction) {
            HStack {
                Text(viewModel.title)
                Spacer()
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .disabled(viewModel.isLoading)
    }
}
