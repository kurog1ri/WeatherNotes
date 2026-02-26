//
//  WeatherResponse.swift
//  WeatherNotes
//
//  Maps directly to OpenWeatherMap /data/2.5/weather JSON response.
//

import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: Main
    let weather: [WeatherCondition]

    struct Main: Decodable {
        let temp: Double
    }

    struct WeatherCondition: Decodable {
        let description: String
        let icon: String
    }

    /// Converts API response into the app's internal WeatherData model.
    func toWeatherData() -> WeatherData {
        let condition = weather.first
        return WeatherData(
            temperature: main.temp,
            description: condition?.description.capitalized ?? "Unknown",
            iconCode: condition?.icon ?? "01d",
            cityName: name
        )
    }
}
