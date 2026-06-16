//
//  WeatherRepo.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 16/06/2026.
//

import Foundation

class WeatherRepo: WeatherRepoProtocol {
    private let dataSource: WeatherRemoteDataSource

    init(dataSource: WeatherRemoteDataSource) {
        self.dataSource = dataSource
    }

    func getForecast(for location: String, days: Int = 3) async throws
        -> WeatherForecast
    {
        do {
            return
                try await dataSource.getForecast(for: location, days: days)
                .toDomainModel()
        } catch let error as APIError {
            throw error
        }
    }

    func searchLocation(query: String) async throws -> [Location] {
        do {
            return
                try await dataSource.searchLocation(query: query).map { $0.toDomainModel() }
        } catch let error as APIError {
            throw error
        }
    }
}
