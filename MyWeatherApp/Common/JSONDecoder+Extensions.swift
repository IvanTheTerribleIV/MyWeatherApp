//
//  JSONDecoder+Extensions.swift
//  MeWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

import Foundation

protocol JSONDecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: JSONDecoderProtocol {}
