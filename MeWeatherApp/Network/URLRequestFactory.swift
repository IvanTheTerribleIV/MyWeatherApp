//
//  URLRequestFactory.swift
//  MeWeatherApp
//
//  Created by Ivan Makarov on 18.07.2025.
//

import Foundation

protocol URLRequestFactoryProtocol {
    static func buildURLRequest(from endpoint: RestEndpoint, on baseUrl: String) throws -> URLRequest
}

struct URLRequestFactory: URLRequestFactoryProtocol {
    static func buildURLRequest(from endpoint: RestEndpoint, on baseUrl: String) throws -> URLRequest {
        guard let fullUrl = URL(string: baseUrl)?.appendingPathComponent(endpoint.path) else { throw URLError(.badURL) }
        guard var urlComponents = URLComponents(url: fullUrl, resolvingAgainstBaseURL: true) else { throw URLError(.badURL) }
        
        var httpBody: Data?
        
        switch endpoint.method {
        case .get:
            urlComponents.queryItems = endpoint.parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        case .post:
            let bodyStringg = endpoint.parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            httpBody = bodyStringg.data(using: .utf8)
        }
        
        guard let url = urlComponents.url else { throw URLError(.badURL) }
        
        var request = URLRequest(url: url)
        request.httpBody = httpBody
        request.httpMethod = endpoint.method.rawValue
                
        return request
    }
}
