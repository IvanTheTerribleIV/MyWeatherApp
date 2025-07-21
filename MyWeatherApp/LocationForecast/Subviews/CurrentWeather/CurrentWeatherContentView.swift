//
//  Untitled.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import SwiftUI

struct CurrentWeatherContentView: View {
    private let viewModel: CurrentWeatherContentViewModel
    
    init(_ viewModel: CurrentWeatherContentViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(viewModel.locationName)
                    .font(.system(size: 20).bold())
                HStack {
                    Text(viewModel.currentTemp)
                        .font(.system(size: 40))
                    AsyncImage(url: viewModel.iconUrl) { image in
                        image.image?.resizable()
                    }
                    .frame(width: 60, height: 60)
                }
                Text(viewModel.conditions)
                    .font(.system(size: 18))
                Text(viewModel.minMaxTemp)
                    .font(.system(size: 20).bold())
            }
            Spacer()
        }
        .background(.black)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
