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
            VStack(spacing: 8) {
                Text(viewModel.locationName)
                    .font(.system(size: 20).bold())
                    .multilineTextAlignment(.center)
                Text(viewModel.currentTemp)
                    .font(.system(size: 60).bold())

                HStack {
                    AsyncImage(url: viewModel.iconUrl) { image in
                        image.image?.resizable()
                            .frame(width: 50, height: 50)
                    }

                    Text(viewModel.conditions)
                        .font(.system(size: 18))
                }
                
                Text(viewModel.minMaxTemp)
                    .font(.system(size: 20).bold())
            }
            Spacer()
        }
        .padding()
        .background(.black)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
