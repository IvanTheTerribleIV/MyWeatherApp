//
//  RestEndpoint.swift
//  MeWeatherApp
//
//  Created by Ivan Makarov on 18.07.2025.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol RestEndpoint {
    var path: String { get }
    var parameters: [String: String] { get }
    var method: HTTPMethod { get }
}
