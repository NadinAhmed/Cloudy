//
//  APIError.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 14/06/2026.
//
import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case noInternetConnection
    case unauthorized
    case notFound
    case serverError(Int)
    case decodingFailed
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .noInternetConnection: return "No internet connection"
        case .unauthorized: return "Invalid API key"
        case .notFound: return "City not found"
        case .serverError(let e): return "Server error (\(e))"
        case .decodingFailed: return "Failed to parse response"
        case .unknown(let e): return e.localizedDescription
        }
    }
}
