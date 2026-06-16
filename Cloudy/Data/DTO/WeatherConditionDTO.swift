//
//  Condition.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 14/06/2026.
//

import Foundation

struct WeatherConditionDTO: Codable {
    let text: String
    let icon: String
    let code: Int
}

extension WeatherConditionDTO {
    func toDomainModel() -> WeatherCondition {
        WeatherCondition(text: text, icon: icon, code: code)
    }
}
