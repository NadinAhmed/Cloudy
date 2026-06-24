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
    private let locationService: LocationServiceProtocol

    private enum Keys {
        static let lastQuery = "lastLocationQuery"
        static let lastTitle = "lastLocationTitle"
        static let useCurrent = "useCurrentLocation"
    }
    private static let defaultQuery = "cairo"

    private(set) var weatherForecast: WeatherForecast?
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?
    private(set) var selectedTitle: String?

    init(repo: WeatherRepoProtocol, locationService: LocationServiceProtocol) {
        self.repo = repo
        self.locationService = locationService
        self.selectedTitle = UserDefaults.standard.string(forKey: Keys.lastTitle)
    }

    private var prefersCurrentLocation: Bool {
        UserDefaults.standard.object(forKey: Keys.useCurrent) as? Bool ?? true
    }

    func fetchWeatherForecast() async {
        isLoading = true
        defer { isLoading = false }

        if prefersCurrentLocation, await fetchForCurrentLocation() {
            return
        }
        await fetchForSavedQuery()
    }

    private func fetchForCurrentLocation() async -> Bool {
        do {
            let coordinate = try await locationService.requestCurrentLocation()
            let query = "\(coordinate.latitude),\(coordinate.longitude)"
            let forecast = try await repo.getForecast(for: query, days: 3)
            weatherForecast = forecast
            selectedTitle = forecast.location.name
            return true
        } catch is LocationError {
            return false
        } catch {
            errorMessage = error.localizedDescription
            return true
        }
    }

    private func fetchForSavedQuery() async {
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
        UserDefaults.standard.set(false, forKey: Keys.useCurrent)
        UserDefaults.standard.set(query, forKey: Keys.lastQuery)
        UserDefaults.standard.set(title, forKey: Keys.lastTitle)
        selectedTitle = title
        await fetchWeatherForecast()
    }

    func useCurrentLocation() async {
        UserDefaults.standard.set(true, forKey: Keys.useCurrent)
        UserDefaults.standard.removeObject(forKey: Keys.lastQuery)
        UserDefaults.standard.removeObject(forKey: Keys.lastTitle)
        selectedTitle = nil
        await fetchWeatherForecast()
    }

    func resetError() {
        errorMessage = nil
    }
}
