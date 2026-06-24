//
//  SearchLocationDTO.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 25/06/2026.
//

import Foundation

struct SearchLocationDTO: Decodable {
    let id: Int
    let name, region, country: String
    let lat, lon: Double
    let url: String
}

extension SearchLocationDTO {
    func toDomainModel() -> Location {
        Location(
            name: name,
            region: region,
            country: country,
            lat: lat,
            lon: lon,
            timezoneId: "",
            localtimeEpoch: 0,
            localtime: ""
        )
    }
}
