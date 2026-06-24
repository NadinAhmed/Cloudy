//
//  DayForecastView.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 24/06/2026.
//

import SwiftUI

struct DayForecastView: View {
    var forecast: ForecastDay

    var body: some View {
        HStack(spacing: 16) {
            Text(forecast.dayName)
                .font(AppFont.forecastRow)
                .lineLimit(1)
            Spacer()
            NetworkImageView(imageURL: forecast.condition.icon)
            Spacer()
            Text(String(format: "%.0f°", forecast.mintempC))
                .font(AppFont.forecastRow)
                .opacity(0.6)
            TempBar(
                min: forecast.mintempC,
                max: forecast.maxtempC,
                avg: forecast.avgtempC
            ).frame(width: 80)
            Text(String(format: "%.0f°", forecast.maxtempC))
                .font(AppFont.forecastRow)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

#Preview {
    DayForecastView(
        forecast: ForecastDay(
            date: "Today",
            dateEpoch: 0,
            maxtempC: 24,
            mintempC: 16,
            avgtempC: 20,
            maxwindKph: 39,
            avgvisKM: 20,
            condition: WeatherCondition(text: "", icon: "", code: 1),
            hours: [
                Weather(
                    lastUpdatedEpoch: 0, time: "",
                    tempC: 2,
                    isDay: 0,
                    condition: WeatherCondition(
                        text: "",
                        icon:
                            "https://cdn.weatherapi.com/weather/64x64/night/113.png",
                        code: 1
                    ),
                    windKph: 23,
                    pressureMB: 12,
                    humidity: 43,
                    feelslikeC: 43,
                    visKM: 65
                )
            ]
        )
    )
}
