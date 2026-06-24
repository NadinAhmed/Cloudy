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

    private enum Keys {
        static let lastQuery = "lastLocationQuery"
        static let lastTitle = "lastLocationTitle"
    }
    private static let defaultQuery = "cairo"

    private(set) var weatherForecast: WeatherForecast?
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?
    private(set) var selectedTitle: String?

    init(repo: WeatherRepoProtocol) {
        self.repo = repo
        self.selectedTitle = UserDefaults.standard.string(forKey: Keys.lastTitle)
    }

    func fetchWeatherForecast() async {
        isLoading = true

        defer { isLoading = false }
        let query =
            UserDefaults.standard.string(forKey: Keys.lastQuery)
            ?? Self.defaultQuery
        do {
            weatherForecast = try await repo.getForecast(for: query, days: 3)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func selectLocation(title: String, query: String) async {
        UserDefaults.standard.set(query, forKey: Keys.lastQuery)
        UserDefaults.standard.set(title, forKey: Keys.lastTitle)
        selectedTitle = title
        await fetchWeatherForecast()
    }

    func resetError() {
        errorMessage = nil
    }
}
