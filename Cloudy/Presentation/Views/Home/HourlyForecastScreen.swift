//
//  HourlyForecastScreen.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 24/06/2026.
//

import SwiftUI

struct HourlyForecastScreen: View {
    let day: ForecastDay
    let isMorning: Bool

    private var hourlyForecast: [Weather] {
        day.hours
    }

    var body: some View {
        BackgroundView(isMorning: isMorning) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    if hourlyForecast.isEmpty {
                        Text("No hourly forecast available.")
                            .font(AppFont.forecastRow)
                            .padding(.top, 8)
                    } else {
                        VStack(spacing: 12) {
                            ForEach(hourlyForecast) { weather in
                                HourlyForecastView(weather: weather)
                            }
                        }
                    }
                }
                .padding(16)
            }
        }
        .navigationTitle("Hourly Forecast")
        .navigationBarTitleDisplayMode(.inline)
    }
}
