//
//  HourlyForecastView.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 24/06/2026.
//

import SwiftUI

struct HourlyForecastView: View {
    let weather: Weather

    var body: some View {
        HStack(spacing: 20) {
            Text(weather.formattedHour)
                .font(AppFont.forecastRow)

            Spacer()

            NetworkImageView(imageURL: weather.condition.icon)

            Spacer()

            Text(String(format: "%.0f°", weather.tempC))
                .font(AppFont.forecastRow)
        }
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.15))
        )
    }
}

#Preview {
    HourlyForecastView(
        weather: Weather(
            lastUpdatedEpoch: nil,
            time: "2023-06-24 08:00",
            tempC: 25.0,
            isDay: 1,
            condition: WeatherCondition(
                text: "Sunny",
                icon: "sun",
                code: 1
            ),
            windKph: 10.0,
            pressureMB: 1013,
            humidity: 60,
            feelslikeC: 27.0,
            visKM: 10.0
        )
    )
}
