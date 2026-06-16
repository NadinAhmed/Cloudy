//
//  ForecastDayDTO.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 16/06/2026.
//

import Foundation

struct ForecastDayDTO: Decodable {
    let date: String
    let dateEpoch: Int
    let day: DayDetailsDTO
    let hour: [WeatherDTO]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, hour
    }
}

extension ForecastDayDTO {
    func toDomainModel() -> ForecastDay {
        ForecastDay(
            date: date,
            dateEpoch: dateEpoch,
            maxtempC: day.maxtempC,
            mintempC: day.mintempC,
            avgtempC: day.avgtempC,
            maxwindKph: day.maxwindKph,
            avgvisKM: day.avgvisKM,
            condition: day.condition.toDomainModel(),
            hours: hour.map {$0.toDomainModel()}
        )
    }
}
