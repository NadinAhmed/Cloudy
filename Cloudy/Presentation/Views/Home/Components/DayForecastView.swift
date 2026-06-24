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
