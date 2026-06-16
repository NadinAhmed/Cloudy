//
//  ForecastResponseDTO.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 16/06/2026.
//

import Foundation

struct ForecastResponseDTO: Decodable {
    let location: LocationDTO
    let current: WeatherDTO
    let forecast: ForecastDTO
}

extension ForecastResponseDTO {
    func toDomainModel() -> WeatherForecast {
        WeatherForecast(
            location: location.toDomainModel(),
            current: current.toDomainModel(),
            days: forecast.toDomainModel()
        )
    }
}
