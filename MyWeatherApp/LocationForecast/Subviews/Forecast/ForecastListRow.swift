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
                HStack {
                    ForEach(viewModel.dayViewModels) { item in
                        VStack {
                            Text(item.time)
                                .font(.system(size: 12))
                            AsyncImage(url: item.iconUrl) { image in
                                image.image?.resizable()
                            }
                            .frame(width: 40, height: 40)
                            Text(item.minMaxTemp)
                                .font(.system(size: 12).bold())
                        }
                    }
                }
            }
            Divider()
                .frame(height: 1)
                .background(.white)
        }
        .padding()
    }
}
