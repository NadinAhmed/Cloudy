//
//  Weather.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 16/06/2026.
//

import Foundation

struct Weather {
    let lastUpdatedEpoch: Int?
    let tempC: Double
    let isDay: Int
    let condition: WeatherCondition
    let windKph: Double
    let pressureMB: Int
    let humidity: Int
    let feelslikeC: Double
    let visKM: Double
}
