//
//  CloudyApp.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 10/06/2026.
//

import SwiftData
import SwiftUI

@main
struct CloudyApp: App {
    init() {
        setupAPIKey()
        setupFont()
    }

    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
        .modelContainer(for: SavedLocation.self)
    }
    
    private func setupFont() {
        let appearance = UINavigationBar.appearance()
        appearance.largeTitleTextAttributes = [
            .font: UIFont(name: "Inter-Bold", size: 34)
                ?? .systemFont(ofSize: 34, weight: .bold)
        ]
        appearance.titleTextAttributes = [
            .font: UIFont(name: "Inter-SemiBold", size: 17)
                ?? .systemFont(ofSize: 17, weight: .semibold)
        ]
    }

    private func setupAPIKey() {
        let key = Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String
        
        guard KeychainManager.shared.load(key: "weather_api_key") == nil else { return }
        
        if let key = key {
            KeychainManager.shared.save(key: "weather_api_key", value: key)
        }
    }
}
