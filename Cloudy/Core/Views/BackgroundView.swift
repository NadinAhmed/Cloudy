//
//  BackgroundView.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 13/06/2026.
//

import SwiftUI

struct BackgroundView<Content: View>: View {
    let content: Content
    var isMorning: Bool
    
    init(isMorning: Bool, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.isMorning = isMorning
    }

    var body: some View {
        ZStack {
            Image(AppTheme.backgroundImage(isMorning: isMorning))
                .resizable()
                .ignoresSafeArea()

            content
        }
        .foregroundColor(AppTheme.textColor(isMorning: isMorning))
    }
}
