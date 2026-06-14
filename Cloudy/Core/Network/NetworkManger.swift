//
//  NetworkManger.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 13/06/2026.
//

import Foundation
import SwiftUI

class NetworkManger {
    static let shared = NetworkManger()
    private init() {}

    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30

        return URLSession(configuration: config)
    }()

    private let interceptor = RequestInterceptor()

    func request<T: Decodable>(
        _ endpoint: String,
        queryItem: [URLQueryItem] = []
    ) async -> Result<T, APIError> {

        guard var component = URLComponents(
                string: APIConstants.baseURL + endpoint
            )
        else { return .failure(.invalidURL) }
        component.queryItems = queryItem

        guard let url = component.url else { return .failure(.invalidURL) }

        let request = interceptor.adapt(URLRequest(url: url))

        do {
            let (data, responce) = try await session.data(for: request)

            guard let http = responce as? HTTPURLResponse else {
                return .failure(.unknown(URLError(.badServerResponse)))
            }
            switch http.statusCode {
            case 200...299:
                break
            case 401:
                return .failure(.unauthorized)
            case 404:
                return .failure(.notFound)
            case 500...599:
                return .failure(.serverError(http.statusCode))
            default:
                return .failure(.serverError(http.statusCode))
            }

            let decode = try JSONDecoder().decode(T.self, from: data)
            return .success(decode)

        } catch is URLError {
            return .failure(.noInternetConnection)
        } catch is DecodingError {
            return .failure(.decodingFailed)
        } catch {
            return .failure(.unknown(error))
        }
    }
}
