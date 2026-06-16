//
//  WeatherRepoProtocol.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 16/06/2026.
//

import Foundation

protocol WeatherRepoProtocol {
    func getForecast(for location: String, days: Int) async throws -> WeatherForecast
    func searchLocation(query: String) async throws -> [Location]
}
