//
//  Forcast.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 14/06/2026.
//

import Foundation

struct ForecastDTO: Decodable {
    let forecastday: [ForecastDayDTO]
}

extension ForecastDTO {
    func toDomainModel() -> [ForecastDay] {
        forecastday.map { $0.toDomainModel() }
    }
}
