//
//  Weather.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 14/06/2026.
//

import Foundation

struct WeatherDTO: Decodable {
    let lastUpdatedEpoch: Int?
    let time: String?
    let tempC: Double
    let isDay: Int
    let condition: WeatherConditionDTO
    let windKph: Double
    let pressureMB: Int
    let humidity: Int
    let feelslikeC: Double
    let visKM: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case time = "time"
        case tempC = "temp_c"
        case isDay = "is_day"
        case condition
        case windKph = "wind_kph"
        case pressureMB = "pressure_mb"
        case humidity
        case feelslikeC = "feelslike_c"
        case visKM = "vis_km"
    }
}

extension WeatherDTO {
    func toDomainModel() -> Weather {
        Weather(
            lastUpdatedEpoch: lastUpdatedEpoch,
            time: time,
            tempC: tempC,
            isDay: isDay,
            condition: condition.toDomainModel(),
            windKph: windKph,
            pressureMB: pressureMB,
            humidity: humidity,
            feelslikeC: feelslikeC,
            visKM: visKM
        )
    }
}
