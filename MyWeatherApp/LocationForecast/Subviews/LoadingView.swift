//
//  LoadingView.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 22.07.2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
                .progressViewStyle(.circular)
                .tint(.white)
                .scaleEffect(2)
            Spacer()
        }
        .frame(height: 200)
        .background(.black)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
