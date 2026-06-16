//
//  NetworkManger.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 13/06/2026.
//

import Foundation
import SwiftUI

protocol NetworkMangerProtocol {
    func request<T: Decodable>(
        _ endpoint: String,
        queryItem: [URLQueryItem]
    ) async throws -> T
}

class NetworkManger: NetworkMangerProtocol {

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30

        return URLSession(configuration: config)
    }()

    private let interceptor = RequestInterceptor()

    func request<T: Decodable>(
        _ endpoint: String,
        queryItem: [URLQueryItem] = []
    ) async throws -> T {

        guard var component = URLComponents(
                string: APIConstants.baseURL + endpoint
            )
        else { throw APIError.invalidURL }
        component.queryItems = queryItem

        guard let url = component.url else { throw APIError.invalidURL }

        let request = interceptor.adapt(URLRequest(url: url))

        do {
            let (data, responce) = try await session.data(for: request)

            guard let http = responce as? HTTPURLResponse else {
                throw APIError.unknown(URLError(.badServerResponse))
            }
            switch http.statusCode {
            case 200...299:
                break
            case 401:
                throw APIError.unauthorized
            case 404:
                throw APIError.notFound
            case 500...599:
                throw APIError.serverError(http.statusCode)
            default:
                throw APIError.serverError(http.statusCode)
            }

            let decode = try JSONDecoder().decode(T.self, from: data)
            return decode

        } catch is URLError {
            throw APIError.noInternetConnection
        } catch is DecodingError {
            throw APIError.decodingFailed
        } catch {
            throw APIError.unknown(error)
        }
    }
}
