//
//  WeatherData.swift
//  WeatherNotes
//

import Foundation

struct WeatherData: Codable, Equatable {
    let temperature: Double       // Celsius
    let description: String       // e.g. "clear sky"
    let iconCode: String          // e.g. "01d"
    let cityName: String

    var iconURL: URL? {
        URL(string: "\(Config.weatherIconBaseURL)/\(iconCode)@2x.png")
    }

    var temperatureFormatted: String {
        "\(Int(temperature.rounded()))°C"
    }
}
