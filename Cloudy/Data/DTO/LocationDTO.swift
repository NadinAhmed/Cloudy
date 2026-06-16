//
//  Location.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 14/06/2026.
//

import Foundation

struct LocationDTO: Decodable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

extension LocationDTO {
    func toDomainModel() -> Location {
        Location(
            name: name,
            region: region,
            country: country,
            lat: lat,
            lon: lon,
            timezoneId: tzID,
            localtimeEpoch: localtimeEpoch,
            localtime: localtime
        )
    }
}
