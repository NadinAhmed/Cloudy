//
//  TempBar.swift
//  Cloudy
//
//  Created by Nadin Ahmed on 24/06/2026.
//

import SwiftUI

struct TempBar: View {
    let min: Double
    let max: Double
    let avg: Double

    private var range: Double { max - min }
    private var avgFraction: Double {
        guard range > 0 else { return 0.5 }
        return (avg - min) / range
    }

    var body: some View {
        GeometryReader { geo in
            let totalWidth = geo.size.width

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.white.opacity(0.15))
                    .frame(height: 4)

                Capsule()
                    .fill(
                        LinearGradient(
                            colors: gradientColors(),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(height: 4)

                Circle()
                    .fill(.white)
                    .frame(width: 8, height: 8)
                    .offset(x: totalWidth * avgFraction - 4)
            }
        }.frame(height: 8)
    }

    private func gradientColors() -> [Color] {
        switch min {
        case ..<0: return [.cyan, .blue]
        case 0..<10: return [.blue, .teal]
        case 10..<20: return [.teal, .yellow]
        case 20..<30: return [.yellow, .orange]
        default: return [.orange, .red]
        }
    }
}

#Preview {
    TempBar(min: 16, max: 24, avg: 19)
}
