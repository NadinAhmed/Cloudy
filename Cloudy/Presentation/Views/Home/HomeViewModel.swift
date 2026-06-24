//
//  HomeViewModel.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 18/06/2026.
//
import Foundation

@Observable
class HomeViewModel {
    private let repo: WeatherRepoProtocol

    private(set) var weatherForecast: WeatherForecast?
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?

    init(repo: WeatherRepoProtocol) {
        self.repo = repo
    }

    func fetchWeatherForecast() async {
        isLoading = true

        defer { isLoading = false }
        do {
            weatherForecast = try await repo.getForecast(for: "cairo", days: 3)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func resetError() {
        errorMessage = nil
    }
}
