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
    let onSelectCurrent: () -> Void

    var body: some View {
        locationsList
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
            Section {
                Button {
                    onSelectCurrent()
                    dismiss()
                } label: {
                    Label("Current Location", systemImage: "location.fill")
                        .font(AppFont.cardValue)
                }
                .buttonStyle(.plain)
                .padding(.vertical, 4)
            }

            Section {
                if locations.isEmpty {
                    Text("Tap + to search and add a location.")
                        .font(AppFont.cardValue)
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(locations) { location in
                        Button {
                            onSelect(location)
                            dismiss()
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(location.displayName)
                                    .font(AppFont.cardValue)
                                Text(location.country)
                                    .font(AppFont.cardLabel)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .buttonStyle(.plain)
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deleteLocations)
                }
            } header: {
                Text("Saved")
            }
        }
    }

    private func deleteLocations(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(locations[index])
        }
    }
}
