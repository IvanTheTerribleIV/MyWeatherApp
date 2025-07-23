//
//  ErrorView.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import SwiftUI

struct ErrorView: View {
    private let viewModel: ErrorViewModel
    
    init(_ viewModel: ErrorViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Text(viewModel.title)
                    .font(.system(size: 18).bold())
                Text(viewModel.subtitle)
                    .font(.system(size: 16).bold())
                Spacer()
                Button(action: viewModel.action) {
                    Text("Try again")
                        .font(.system(size: 14).bold())
                }
                .frame(width: 100, height: 40)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .foregroundStyle(.white)
            .padding()
            Spacer()
        }
        .frame(height: 200)
        .background(.black)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
