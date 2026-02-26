//
//  WeatherData+UI.swift
//  WeatherNotes
//

import SwiftUI

extension WeatherData {

    /// Color based on temperature value.
    var temperatureColor: Color {
        switch temperature {
        case ..<0:    return Color(red: 0.3, green: 0.6, blue: 1.0)   // icy blue
        case 0..<10:  return .cyan
        case 10..<20: return .green
        case 20..<30: return .orange
        default:      return .red
        }
    }

    /// Accent color based on OWM icon code prefix.
    var conditionColor: Color {
        switch String(iconCode.prefix(2)) {
        case "01": return .orange                                        // clear sky
        case "02": return .yellow                                        // few clouds
        case "03", "04": return Color(red: 0.5, green: 0.6, blue: 0.8) // scattered/broken
        case "09", "10": return .blue                                    // rain
        case "11": return .purple                                        // thunderstorm
        case "13": return Color(red: 0.6, green: 0.85, blue: 1.0)      // snow
        case "50": return Color(red: 0.6, green: 0.6, blue: 0.65)      // mist/fog
        default:   return .blue
        }
    }
}
