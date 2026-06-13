//
//  BackgroundView.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 13/06/2026.
//

import SwiftUI

struct BackgroundView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            Image(AppTheme.backgroundImage(isMorning: AppTheme.isMorning))
                .resizable()
                .ignoresSafeArea()

            content
        }
        .foregroundColor(AppTheme.textColor(isMorning: AppTheme.isMorning))
    }
}
