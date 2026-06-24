//
//  LocationService.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 25/06/2026.
//

import CoreLocation

enum LocationError: Error {
    case denied
    case unavailable
}

protocol LocationServiceProtocol {
    func requestCurrentLocation() async throws -> CLLocationCoordinate2D
}

@MainActor
final class LocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var continuation: CheckedContinuation<CLLocationCoordinate2D, Error>?
    private var timeoutTask: Task<Void, Never>?

    private let timeout: Duration = .seconds(10)

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
    }

    func requestCurrentLocation() async throws -> CLLocationCoordinate2D {
        try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            startTimeout()

            switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()
            case .denied, .restricted:
                resume(throwing: LocationError.denied)
            @unknown default:
                resume(throwing: LocationError.unavailable)
            }
        }
    }

    nonisolated func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        Task { @MainActor in
            guard continuation != nil else { return }
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                manager.startUpdatingLocation()
            case .denied, .restricted:
                resume(throwing: LocationError.denied)
            case .notDetermined:
                break
            @unknown default:
                resume(throwing: LocationError.unavailable)
            }
        }
    }

    nonisolated func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        Task { @MainActor in
            guard let coordinate = locations.last?.coordinate else { return }
            resume(returning: coordinate)
        }
    }

    nonisolated func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        Task { @MainActor in
            if let clError = error as? CLError, clError.code == .locationUnknown {
                return
            }
            resume(throwing: LocationError.unavailable)
        }
    }

    private func startTimeout() {
        timeoutTask?.cancel()
        timeoutTask = Task { @MainActor [weak self] in
            try? await Task.sleep(for: self?.timeout ?? .seconds(10))
            guard !Task.isCancelled else { return }
            self?.resume(throwing: LocationError.unavailable)
        }
    }

    private func resume(returning coordinate: CLLocationCoordinate2D) {
        finish()
        continuation?.resume(returning: coordinate)
        continuation = nil
    }

    private func resume(throwing error: Error) {
        finish()
        continuation?.resume(throwing: error)
        continuation = nil
    }

    private func finish() {
        timeoutTask?.cancel()
        timeoutTask = nil
        manager.stopUpdatingLocation()
    }
}
