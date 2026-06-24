//
//  Weather.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 16/06/2026.
//

import Foundation

struct Weather : Identifiable {
    var id: String { time ?? UUID().uuidString }
    let lastUpdatedEpoch: Int?
    let time: String?
    var formattedHour: String {
        guard let time = time else { return "" }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let dateObj = formatter.date(from: time) else { return time }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "h a"
        return outputFormatter.string(from: dateObj)
    }
    let tempC: Double
    let isDay: Int
    let condition: WeatherCondition
    let windKph: Double
    let pressureMB: Double
    let humidity: Int
    let feelslikeC: Double
    let visKM: Double
}
