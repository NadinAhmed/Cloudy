//
//  NetworkImageView.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 24/06/2026.
//

import SwiftUI

struct NetworkImageView: View {
    var imageURL: String

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) { phase in
            switch phase {
            case .empty, .failure:
                Image(systemName: "cloud")
                    .foregroundStyle(.white)
            case .success(let image):
                image.resizable()
                    .scaledToFit()
            @unknown default:
                EmptyView()
            }
        }.frame(width: 28, height: 28)
    }
}

#Preview {
    NetworkImageView(
        imageURL: "https://cdn.weatherapi.com/weather/64x64/night/113.png"
    )
}
