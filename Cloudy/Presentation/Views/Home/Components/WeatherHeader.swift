//
//  WeatherHeader.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 24/06/2026.
//

import SwiftUI

struct WeatherHeader: View {
    let weather: WeatherForecast

    var body: some View {
        VStack(spacing: 4) {
            Text(weather.location.name)
                .font(AppFont.cityName)
            
            Text(String(format: "%.0f°", weather.current.tempC))
                .font(AppFont.temperature)
            
            Text(weather.current.condition.text)
                .font(AppFont.condition)
                .opacity(0.75)
            
            let maxTemp =
                weather.days[0].maxtempC
                .formatted(
                    .number.precision(.fractionLength(0))
                ) + "°"
            let minTemp =
                weather.days[0].mintempC
                .formatted(
                    .number.precision(.fractionLength(0))
                ) + "°"

            Text("H:\(maxTemp)  L:\(minTemp)")
                .font(AppFont.highLow).opacity(0.6)
        }
    }
}
