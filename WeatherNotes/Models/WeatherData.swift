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

    var temperatureFormatted: String {
        "\(Int(temperature.rounded()))°C"
    }
}
