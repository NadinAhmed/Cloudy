//
//  ForecastDay.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 16/06/2026.
//

import Foundation

struct ForecastDay {
    let date: String
    let dateEpoch: Int
    let maxtempC, mintempC, avgtempC: Double
    let maxwindKph: Double
    let avgvisKM: Double
    let condition: WeatherCondition
    let hours: [Weather]
}
