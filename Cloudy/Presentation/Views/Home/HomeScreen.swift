//
//  ContentView.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 10/06/2026.
//

import SwiftData
import SwiftUI

struct HomeScreen: View {
    @State var viewModel = DIContainer.shared.container.resolve(
        HomeViewModel.self
    )!

    var body: some View {
        NavigationStack {
            contentView
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            LocationsScreen { location in
                                Task {
                                    await viewModel.selectLocation(
                                        title: location.displayName,
                                        query: location.query
                                    )
                                }
                            } onSelectCurrent: {
                                Task {
                                    await viewModel.useCurrentLocation()
                                }
                            }
                        } label: {
                            Image(systemName: "list.bullet")
                        }
                    }
                }
        }
        .task {
            await viewModel.fetchWeatherForecast()
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if viewModel.isLoading {
            ProgressView()
        } else if let error = viewModel.errorMessage {
            ErrorScreen(errorMessage: error) {
                Task {
                    viewModel.resetError()
                    await viewModel.fetchWeatherForecast()
                }
            }
        } else if let forecast = viewModel.weatherForecast {
            let isMorning = forecast.current.isDay == 1

            BackgroundView(isMorning: isMorning) {
                ScrollView {
                    VStack(spacing: 32) {
                        WeatherHeader(weather: forecast)
                        VStack(alignment: .leading, spacing: 12) {
                            Label("3-DAY FORECAST", systemImage: "calendar")
                                .font(AppFont.forecastTitle)
                                .opacity(0.6)
                                .padding(.horizontal, 20)
                                .padding(.top, 16)

                            Divider().background(.white.opacity(0.5))

                            ForEach(forecast.days, id: \.id) { day in
                                NavigationLink {
                                    HourlyForecastScreen(
                                        day: day,
                                        isMorning: isMorning
                                    )
                                } label: {
                                    DayForecastView(forecast: day)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.15))
                        )
                    }

                    Spacer(minLength: 16)

                    let columns = [
                        GridItem(.flexible(), spacing: 16),
                        GridItem(.flexible(), spacing: 16),
                    ]
                    let weather = forecast.current

                    LazyVGrid(columns: columns, spacing: 16) {
                        DetailCard(
                            icon: "eye",
                            title: "VISIBILITY",
                            value: "\(weather.visKM.formatted()) km",
                            subtitle: weather.visKM > 9
                                ? "Perfectly clear" : "Reduced visibility"
                        )
                        DetailCard(
                            icon: "drop",
                            title: "HUMIDITY",
                            value: "\(weather.humidity)%",
                            subtitle: weather.humidity < 30
                                ? "Dry"
                                : (weather.humidity < 60
                                    ? "Comfortable" : "Humid")
                        )
                        DetailCard(
                            icon: "thermometer",
                            title: "FEELS LIKE",
                            value:
                                "\(weather.feelslikeC.formatted(.number.precision(.fractionLength(0))))°",
                            subtitle: weather.feelslikeC > weather.tempC
                                ? "Warmer than actual"
                                : (weather.feelslikeC < weather.tempC
                                    ? "Colder than actual"
                                    : "Similar to actual")
                        )
                        DetailCard(
                            icon: "gauge",
                            title: "PRESSURE",
                            value: "\(weather.pressureMB)",
                            subtitle: weather.pressureMB > 1015
                                ? "hPa — High"
                                : (weather.pressureMB < 1005
                                    ? "hPa — Low" : "hPa — Normal")
                        )
                    }

                }.preferredColorScheme(isMorning ? .light : .dark)
                    .padding(.horizontal, 16)
            }
        }
    }
}
