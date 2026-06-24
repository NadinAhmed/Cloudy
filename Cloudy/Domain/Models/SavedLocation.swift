//
//  SavedLocation.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 25/06/2026.
//

import Foundation
import SwiftData

@Model
final class SavedLocation {
    var name: String
    var region: String
    var country: String
    var lat: Double
    var lon: Double
    var savedAt: Date

    init(
        name: String,
        region: String,
        country: String,
        lat: Double,
        lon: Double,
        savedAt: Date = .now
    ) {
        self.name = name
        self.region = region
        self.country = country
        self.lat = lat
        self.lon = lon
        self.savedAt = savedAt
    }

    var query: String { "\(lat),\(lon)" }

    var displayName: String {
        region.isEmpty ? name : "\(name), \(region)"
    }
}
