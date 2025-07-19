//
//  JSONDecoder+Extensions.swift
//  MeWeatherApp
//
//  Created by Ivan Makarov on 19.07.2025.
//

protocol JSONDecoderProtocol {
    open func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: JSONDecoderProtocol {}
