//
//  RequestInterceptor.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 14/06/2026.
//
import Foundation

struct RequestInterceptor {
    private let apiKey: String

    init() {
        self.apiKey = KeychainManager.shared.load(key: "weather_api_key") ?? ""
    }

    func adapt(_ request: URLRequest) -> URLRequest {
        guard var components = URLComponents(
                url: request.url!,
                resolvingAgainstBaseURL: false
            )
        else { return request }
        
        var queryItems = components.queryItems ?? []
        queryItems.append(URLQueryItem(name: APIConstants.apiKey, value: apiKey))
        components.queryItems = queryItems
        
        var adapted = request
        adapted.url = components.url
        return adapted
    }
}
