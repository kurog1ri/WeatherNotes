//
//  WeatherIconView.swift
//  WeatherNotes
//

import SwiftUI

struct WeatherIconView: View {

    let iconCode: String?
    let size: CGFloat

    @Environment(\.colorScheme) private var colorScheme

    init(iconCode: String?, size: CGFloat = 32) {
        self.iconCode = iconCode
        self.size = size
    }

    var body: some View {
        ZStack {
            Circle()
                .fill(conditionColor.opacity(0.15))
                .frame(width: size + 16, height: size + 16)

            if colorScheme == .dark {
                Image(systemName: sfSymbolName)
                    .symbolRenderingMode(.multicolor)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
            } else {
                Image(systemName: sfSymbolName)
                    .symbolRenderingMode(.monochrome)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .foregroundStyle(.primary)
            }
        }
    }

    // MARK: - OWM icon code → SF Symbol

    private var sfSymbolName: String {
        switch iconCode {
        case "01d":           return "sun.max.fill"
        case "01n":           return "moon.stars.fill"
        case "02d":           return "cloud.sun.fill"
        case "02n":           return "cloud.moon.fill"
        case "03d", "03n":    return "cloud.fill"
        case "04d", "04n":    return "smoke.fill"
        case "09d", "09n":    return "cloud.drizzle.fill"
        case "10d":           return "cloud.rain.fill"
        case "10n":           return "cloud.rain.fill"
        case "11d", "11n":    return "cloud.bolt.fill"
        case "13d", "13n":    return "cloud.snow.fill"
        case "50d", "50n":    return "cloud.fog.fill"
        default:              return "cloud.fill"
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
}

#Preview {
    HStack(spacing: 20) {
        WeatherIconView(iconCode: "01d", size: 36)
        WeatherIconView(iconCode: "10d", size: 36)
        WeatherIconView(iconCode: "13d", size: 36)
        WeatherIconView(iconCode: "11d", size: 36)
        WeatherIconView(iconCode: nil,   size: 36)
    }
    .padding()
}
