//
//  LocationSearchViewModel.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 25/06/2026.
//

import Foundation

@Observable
class LocationSearchViewModel {
    private let repo: WeatherRepoProtocol

    var query: String = ""
    private(set) var results: [Location] = []
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String?

    init(repo: WeatherRepoProtocol) {
        self.repo = repo
    }

    func search() async {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            results = []
            return
        }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        do {
            results = try await repo.searchLocation(query: trimmed)
        } catch {
            errorMessage = error.localizedDescription
            results = []
        }
    }

    func clear() {
        query = ""
        results = []
        errorMessage = nil
    }
}
