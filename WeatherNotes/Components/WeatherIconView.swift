//
//  WeatherIconView.swift
//  WeatherNotes
//

import SwiftUI

struct WeatherIconView: View {

    let iconCode: String?
    let size: CGFloat

    init(iconCode: String?, size: CGFloat = 32) {
        self.iconCode = iconCode
        self.size = size
    }

    var body: some View {
        if let code = iconCode,
           let url = URL(string: "https://openweathermap.org/img/wn/\(code)@2x.png") {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: size, height: size)
                case .failure, .empty:
                    fallbackIcon
                @unknown default:
                    fallbackIcon
                }
            }
        } else {
            fallbackIcon
        }
    }

    private var fallbackIcon: some View {
        Image(systemName: "cloud.fill")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundStyle(.secondary)
    }
}

#Preview {
    HStack(spacing: 20) {
        WeatherIconView(iconCode: "01d", size: 40)
        WeatherIconView(iconCode: nil, size: 40)
    }
    .padding()
}
