//
//  WeatherNote.swift
//  WeatherNotes
//

import Foundation

struct WeatherNote: Identifiable, Codable, Equatable {
    let id: UUID
    let text: String
    let createdAt: Date
    let weather: WeatherData?

    init(id: UUID = UUID(), text: String, createdAt: Date = Date(), weather: WeatherData? = nil) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.weather = weather
    }
}
