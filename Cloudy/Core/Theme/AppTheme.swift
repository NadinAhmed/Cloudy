//
//  AppTheme.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 13/06/2026.
//

import Foundation
import SwiftUI

struct AppTheme {
    static let primaryColor = Color("PrimaryColor")
    static let secondaryColor = Color("ScondaryColor")

    static func textColor(isMorning: Bool) -> Color {
        isMorning ? Color("TextDark") : Color("TextLight")
    }

    static func backgroundImage(isMorning: Bool) -> String {
        isMorning ? "MorningBG" : "EveningBG"
    }

    static var isMorning: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour >= 5 && hour < 18
    }
}
