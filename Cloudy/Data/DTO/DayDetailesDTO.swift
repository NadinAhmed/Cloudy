//
//  DayDetailesDTO.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 16/06/2026.
//

import Foundation

struct DayDetailsDTO: Decodable {
    let maxtempC, mintempC, avgtempC: Double
    let maxwindKph: Double
    let avgvisKM: Double
    let condition: WeatherConditionDTO

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case avgtempC = "avgtemp_c"
        case maxwindKph = "maxwind_kph"
        case avgvisKM = "avgvis_km"
        case condition
    }
}
