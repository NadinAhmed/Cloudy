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
        let appearance = UINavigationBar.appearance()
        appearance.largeTitleTextAttributes = [
            .font: SwiftUI.Font.custom("Inter-Bold", size: 34)
        ]
        appearance.titleTextAttributes = [
            .font: SwiftUI.Font.custom("Inter-SemiBold", size: 17)
        ]
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
