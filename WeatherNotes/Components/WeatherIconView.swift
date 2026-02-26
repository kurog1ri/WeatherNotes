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
        ZStack {
            Circle()
                .fill(conditionColor.opacity(0.15))
                .frame(width: size + 16, height: size + 16)

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
    }

    private var conditionColor: Color {
        guard let code = iconCode else { return .blue }
        switch String(code.prefix(2)) {
        case "01": return .orange
        case "02": return .yellow
        case "03", "04": return Color(red: 0.5, green: 0.6, blue: 0.8)
        case "09", "10": return .blue
        case "11": return .purple
        case "13": return Color(red: 0.6, green: 0.85, blue: 1.0)
        case "50": return Color(red: 0.6, green: 0.6, blue: 0.65)
        default:   return .blue
        }
    }

    private var fallbackIcon: some View {
        Image(systemName: "cloud.fill")
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundStyle(conditionColor)
    }
}

#Preview {
    HStack(spacing: 24) {
        WeatherIconView(iconCode: "01d", size: 36)
        WeatherIconView(iconCode: "10d", size: 36)
        WeatherIconView(iconCode: "13d", size: 36)
        WeatherIconView(iconCode: nil,   size: 36)
    }
    .padding()
}
