//
//  WeatherRemoteDataSource.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 16/06/2026.
//

import Foundation

class WeatherRemoteDataSource {
    private let network: NetworkMangerProtocol

    init(network: NetworkMangerProtocol) {
        self.network = network
    }

    func getForecast(for location: String, days: Int) async throws -> ForecastResponseDTO {
        let items = [
            URLQueryItem(name: "q", value: location),
            URLQueryItem(name: "days", value: String(days)),
        ]

        return try await network.request(APIConstants.forcast, queryItem: items)
    }

    func searchLocation(query: String) async throws -> [LocationDTO] {
        let items = [
            URLQueryItem(name: "q", value: query)
        ]

        return try await network.request(APIConstants.search, queryItem: items)
    }
}
