//
//  LocationsScreen.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 25/06/2026.
//

import SwiftData
import SwiftUI

struct LocationsScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \SavedLocation.savedAt) private var locations: [SavedLocation]

    let onSelect: (SavedLocation) -> Void

    var body: some View {
        Group {
            if locations.isEmpty {
                emptyState
            } else {
                locationsList
            }
        }
        .navigationTitle("Locations")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    LocationSearchScreen()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }

    private var locationsList: some View {
        List {
            ForEach(locations) { location in
                Button {
                    onSelect(location)
                    dismiss()
                } label: {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(location.displayName)
                            .font(.headline)
                        Text(location.country)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .buttonStyle(.plain)
            }
            .onDelete(perform: deleteLocations)
        }
    }

    private var emptyState: some View {
        ContentUnavailableView {
            Label("No Saved Locations", systemImage: "mappin.slash")
        } description: {
            Text("Tap + to search and add a location.")
        }
    }

    private func deleteLocations(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(locations[index])
        }
    }
}
