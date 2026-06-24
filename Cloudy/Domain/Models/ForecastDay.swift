//
//  ForecastDay.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 16/06/2026.
//

import Foundation
import SwiftUI

struct ForecastDay: Identifiable {
    var id: String { date }
    let date: String
    var dayName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let dateObj = formatter.date(from: date) else { return date }

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE"
        return outputFormatter.string(from: dateObj)
    }
    let dateEpoch: Int
    let maxtempC, mintempC, avgtempC: Double
    let maxwindKph: Double
    let avgvisKM: Double
    let condition: WeatherCondition
    let hours: [Weather]
}
