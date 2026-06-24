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
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.15))
        )
    }
}
