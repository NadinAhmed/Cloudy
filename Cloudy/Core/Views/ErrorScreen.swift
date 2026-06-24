//
//  ErrorScreen.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 19/06/2026.
//

import SwiftUI

struct ErrorScreen: View {
    let errorMessage: String
    let onRetryClicked: (() -> Void)?

    var body: some View {
        VStack {
            Text(errorMessage)
                .multilineTextAlignment(.center)
                .font(AppFont.cardValue)
                .foregroundColor(AppTheme.primaryColor)
                .padding()

            if let onClick = onRetryClicked {
                Button("Retry", action: onClick)
                    .foregroundColor(.white)
                    .frame(width: 100, height: 40)
                    .background(AppTheme.primaryColor)
                    .cornerRadius(12)
            }
        }
    }
}

#Preview {
    ErrorScreen(errorMessage: "Test", onRetryClicked: {})
}
