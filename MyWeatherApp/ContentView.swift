//
//  ContentView.swift
//  MeWeatherApp
//
//  Created by Ivan Makarov on 18.07.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        Text("Select an item")
            .task {
                do {
                    let current = try await OpenWeatherDataSource().getCurrentWeather(lat: 41.415518, lon: 2.194770)
                    let forecast = try await OpenWeatherDataSource().getForecast(lat: 41.415518, lon: 2.194770)
                    
                    print(current)
                    print(forecast)
                } catch {
                    print(error)
                }
                
            }
    }

}

#Preview {
    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
}

//"oQ4DexA6pBsjrlnYJzjN0ry3EdrZGD1G"
////        .init(name: "AccuWeather", baseUrl: "http://dataservice.accuweather.com")


