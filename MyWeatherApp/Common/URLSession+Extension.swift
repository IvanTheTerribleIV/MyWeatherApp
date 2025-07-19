//
//  URLSession+Extension.swift
//  MyWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import Foundation

protocol URLSessionType {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionType {}
