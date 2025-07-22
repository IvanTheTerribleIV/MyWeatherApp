//
//  ForecastListRow.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 20.07.2025.
//

import SwiftUI

struct ForecastListRow: View {
    private let viewModel: ForecasetListRowViewModel
    
    init(_ viewModel: ForecasetListRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.weekDay)
            Spacer()
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(viewModel.dayViewModels) { item in
                        VStack {
                            Text(item.time)
                                .font(.system(size: 14))
                            AsyncImage(url: item.iconUrl) { image in
                                image.image?.resizable()
                            }
                            .frame(width: 50, height: 50)
                            Text(item.minMaxTemp)
                                .font(.system(size: 12).bold())
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            Divider()
                .frame(height: 1)
                .background(.white)
        }
        .padding()
    }
}
