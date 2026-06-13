//
//  AppFont.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 13/06/2026.
//

import Foundation
import SwiftUI

struct AppFont{
    struct Font {
            static let cityName = SwiftUI.Font.custom("Inter-Bold", size: 34)
            static let temperature = SwiftUI.Font.custom("Inter-Medium", size: 96)
            static let condition = SwiftUI.Font.custom("Inter-Regular", size: 20)
            static let highLow = SwiftUI.Font.custom("Inter-Regular", size: 15)
            static let forecastTitle = SwiftUI.Font.custom("Inter-SemiBold", size: 12)
            static let forecastRow = SwiftUI.Font.custom("Inter-Regular", size: 17)
            static let cardLabel = SwiftUI.Font.custom("Inter-SemiBold", size: 12)
            static let cardValue = SwiftUI.Font.custom("Inter-Bold", size: 22)
        }
}
