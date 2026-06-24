//
//  DetailCard.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 24/06/2026.
//

import SwiftUI

struct DetailCard: View {
    let icon: String
    let title: String
    let value: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label(title, systemImage: icon)
                .font(AppFont.cardLabel)
                .opacity(0.6)

            Text(value)
                .font(AppFont.cardValue)

            Spacer()

            Text(subtitle)
                .font(AppFont.cardLabel)
                .opacity(0.8)
        }.padding(16)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.15))
            )
    }
}

#Preview {
    DetailCard(
        icon: "eye",
        title: "VISIBILITY",
        value: "123 km",
        subtitle: 3 > 9
            ? "Perfectly clear" : "Reduced visibility"
    )
}
