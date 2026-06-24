//
//  LocationSearchScreen.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 25/06/2026.
//

import SwiftData
import SwiftUI

struct LocationSearchScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var savedLocations: [SavedLocation]

    @State private var viewModel = DIContainer.shared.container.resolve(
        LocationSearchViewModel.self
    )!

    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let error = viewModel.errorMessage {
                ContentUnavailableView(
                    "Something went wrong",
                    systemImage: "exclamationmark.triangle",
                    description: Text(error)
                )
            } else if viewModel.results.isEmpty {
                ContentUnavailableView.search(text: viewModel.query)
            } else {
                resultsList
            }
        }
        .navigationTitle("Add Location")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
            text: $viewModel.query,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search for a city"
        )
        .onSubmit(of: .search) {
            Task { await viewModel.search() }
        }
        .onChange(of: viewModel.query) { _, newValue in
            if newValue.trimmingCharacters(in: .whitespaces).isEmpty {
                viewModel.clear()
            }
        }
    }

    private var resultsList: some View {
        List(viewModel.results, id: \.lat) { location in
            Button {
                add(location)
            } label: {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(
                            location.region.isEmpty
                                ? location.name
                                : "\(location.name), \(location.region)"
                        )
                        .font(.headline)
                        Text(location.country)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if isAlreadySaved(location) {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .buttonStyle(.plain)
            .disabled(isAlreadySaved(location))
        }
    }

    private func isAlreadySaved(_ location: Location) -> Bool {
        savedLocations.contains {
            $0.lat == location.lat && $0.lon == location.lon
        }
    }

    private func add(_ location: Location) {
        guard !isAlreadySaved(location) else { return }
        let saved = SavedLocation(
            name: location.name,
            region: location.region,
            country: location.country,
            lat: location.lat,
            lon: location.lon
        )
        modelContext.insert(saved)
        dismiss()
    }
}
